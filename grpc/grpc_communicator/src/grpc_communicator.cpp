#include <grpc_communicator/grpc_communicator.h>
#include <grpcpp/security/server_credentials.h>
#include <grpcpp/server.h>
#include <grpcpp/server_builder.h>
#include <schedule/external_recipe_meal.h>
#include <schedule/leftovers_meal.h>
#include <schedule/other_meal.h>
#include <schedule/recipe_meal.h>

#include <chrono>
#include <memory>
#include <string>
#include <thread>
#include <utility>

#include "schedule/leftovers_meal.h"
#include "tabetai2.grpc.pb.h"
#include "tabetai2.pb.h"

namespace tabetai2::grpc_communicator {

using namespace core::database;
using namespace core::ingredient;
using namespace core::recipe;
using namespace core::schedule;
using namespace core::util;

class Tabetai2Impl final : public Tabetai2::Service, public Observer {
public:
    explicit Tabetai2Impl(std::shared_ptr<IngredientRepository> ingredient_repository,
                          std::shared_ptr<RecipeRepository> recipe_repository,
                          std::shared_ptr<ScheduleRepository> schedule_repository,
                          std::shared_ptr<IdGenerator> id_generator) :
    m_ingredient_repository{std::move(ingredient_repository)},
    m_recipe_repository{std::move(recipe_repository)},
    m_schedule_repository{std::move(schedule_repository)},
    m_id_generator{std::move(id_generator)} {
        m_ingredient_repository->add_observer(this);
        m_recipe_repository->add_observer(this);
        m_schedule_repository->add_observer(this);
    };

    grpc::Status list_ingredients(grpc::ServerContext *context,
                                  const ListIngredientsRequest *request,
                                  grpc::ServerWriter<::Ingredient> *writer) override {
        for (const auto &ingredient : m_ingredient_repository->find_all()) {
            ::Ingredient ingredient_entry;
            ingredient_entry.set_id(ingredient.id());
            ingredient_entry.set_name(ingredient.name());
            writer->Write(ingredient_entry);
        }
        return grpc::Status::OK;
    }

    grpc::Status list_recipes(grpc::ServerContext *context,
                              const ListRecipesRequest *request,
                              grpc::ServerWriter<::Recipe> *writer) override {
        for (const auto &recipe : m_recipe_repository->find_all()) {
            ::Recipe recipe_entry;
            recipe_entry.set_id(recipe.id());
            recipe_entry.set_name(recipe.name());
            recipe_entry.set_servings(recipe.servings());
            for (const auto &recipe_ingredient : recipe.ingredients()) {
                auto ingredient = recipe_ingredient.first;
                auto quantity = recipe_ingredient.second;

                auto recipe_ingredient_entry = recipe_entry.add_ingredients();
                recipe_ingredient_entry->set_id(ingredient.id());
                auto quantity_entry = recipe_ingredient_entry->mutable_quantity();
                quantity_entry->set_amount(quantity->amount());
                quantity_entry->set_unit(static_cast<::Unit>(quantity->unit()));
            }
            for (const auto &recipe_step : recipe.steps()) {
                recipe_entry.add_steps(recipe_step);
            }
            writer->Write(recipe_entry);
        }
        return grpc::Status::OK;
    }

    grpc::Status list_schedules(grpc::ServerContext *context,
                                const ListSchedulesRequest *request,
                                grpc::ServerWriter<::Schedule> *writer) override {
        for (const auto &schedule : m_schedule_repository->find_all()) {
            ::Schedule schedule_entry;
            schedule_entry.set_id(schedule.id());
            schedule_entry.set_start_date(schedule.start_date());
            for (const auto &day : schedule.days()) {
                auto day_entry = schedule_entry.add_days();
                for (const auto &meal : day.meals()) {
                    auto schedule_day_meal_entry = day_entry->add_meals();
                    switch (meal->type()) {
                        case MealType::Recipe: {
                            auto recipe_meal = dynamic_cast<const tabetai2::core::schedule::RecipeMeal &>(*meal);

                            schedule_day_meal_entry->set_type(::MealType::RECIPE);

                            auto recipe_meal_entry = schedule_day_meal_entry->mutable_recipe_meal();
                            recipe_meal_entry->set_recipe_id(recipe_meal.recipe().id());

                            auto meal_entry = recipe_meal_entry->mutable_meal();
                            meal_entry->set_title(recipe_meal.title());
                            meal_entry->set_servings(recipe_meal.servings());
                            meal_entry->set_comment(recipe_meal.comment());
                            break;
                        }
                        case MealType::ExternalRecipe: {
                            auto external_recipe_meal =
                                dynamic_cast<const tabetai2::core::schedule::ExternalRecipeMeal &>(*meal);

                            schedule_day_meal_entry->set_type(::MealType::EXTERNAL_RECIPE);

                            auto external_recipe_meal_entry = schedule_day_meal_entry->mutable_external_recipe_meal();
                            external_recipe_meal_entry->set_url(external_recipe_meal.url());

                            auto meal_entry = external_recipe_meal_entry->mutable_meal();
                            meal_entry->set_title(external_recipe_meal.title());
                            meal_entry->set_servings(external_recipe_meal.servings());
                            meal_entry->set_comment(external_recipe_meal.comment());
                            break;
                        }
                        case MealType::Leftovers: {
                            auto leftovers_meal = dynamic_cast<const tabetai2::core::schedule::LeftoversMeal &>(*meal);

                            schedule_day_meal_entry->set_type(::MealType::LEFTOVERS);

                            auto leftovers_meal_entry = schedule_day_meal_entry->mutable_leftovers_meal();
                            auto meal_entry = leftovers_meal_entry->mutable_meal();
                            meal_entry->set_title(leftovers_meal.title());
                            meal_entry->set_servings(leftovers_meal.servings());
                            meal_entry->set_comment(leftovers_meal.comment());
                            break;
                        }
                        case MealType::Other: {
                            auto other_meal = dynamic_cast<const tabetai2::core::schedule::OtherMeal &>(*meal);

                            schedule_day_meal_entry->set_type(::MealType::OTHER);

                            auto other_meal_entry = schedule_day_meal_entry->mutable_other_meal();
                            auto meal_entry = other_meal_entry->mutable_meal();
                            meal_entry->set_title(other_meal.title());
                            meal_entry->set_servings(other_meal.servings());
                            meal_entry->set_comment(other_meal.comment());
                            break;
                        }
                    }
                }
            }
            writer->Write(schedule_entry);
        }
        return grpc::Status::OK;
    }

    grpc::Status add_ingredient(grpc::ServerContext *context,
                                const AddIngredientRequest *request,
                                AddIngredientResponse *ingredient_id) override {
        if (request->name().empty()) {
            return grpc::Status::CANCELLED;
        }

        auto id = m_id_generator->generate();
        m_ingredient_repository->add(Ingredient(id, request->name()));
        ingredient_id->set_ingredient_id(id);
        return grpc::Status::OK;
    }

    grpc::Status add_recipe(grpc::ServerContext *context,
                            const AddRecipeRequest *request,
                            AddRecipeResponse *recipe_id) override {
        if (request->name().empty()) {
            return grpc::Status::CANCELLED;
        }

        std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients;
        for (const auto &ingredient_entry : request->ingredients()) {
            const auto &quantity_entry = ingredient_entry.quantity();
            auto quantity =
                std::make_optional(Quantity{quantity_entry.amount(), static_cast<Unit>(quantity_entry.unit())});
            auto ingredient = m_ingredient_repository->find_by_id(ingredient_entry.id());
            if (!ingredient) {
                return {grpc::StatusCode::ABORTED, "Invalid ingredient ID in recipe"};
            }
            ingredients.emplace_back(ingredient.value(), quantity);
        }

        std::vector<std::string> steps(request->steps().size());
        std::copy(request->steps().begin(), request->steps().end(), steps.begin());

        auto id = m_id_generator->generate();
        m_recipe_repository->add(
            Recipe{id, std::string(request->name()), static_cast<unsigned>(request->servings()), ingredients, steps});
        recipe_id->set_recipe_id(id);
        return grpc::Status::OK;
    }

    grpc::Status add_schedule(grpc::ServerContext *context,
                              const AddScheduleRequest *request,
                              AddScheduleResponse *schedule_id) override {
        auto id = m_id_generator->generate();
        Schedule schedule{id, request->start_date()};
        for (const auto &day_entry : request->days()) {
            core::schedule::ScheduleDay day;
            for (const auto &schedule_day_meal_entry : day_entry.meals()) {
                switch (schedule_day_meal_entry.type()) {
                    case ::MealType::RECIPE: {
                        auto recipe_meal_entry = schedule_day_meal_entry.recipe_meal();
                        auto recipe = m_recipe_repository->find_by_id(recipe_meal_entry.recipe_id());
                        if (!recipe) {
                            return {grpc::StatusCode::ABORTED, "Invalid recipe ID in schedule"};
                        }
                        day.add_meal(std::make_unique<core::schedule::RecipeMeal>(
                            *recipe, recipe_meal_entry.meal().servings(), recipe_meal_entry.meal().comment()));
                        break;
                    }
                    case ::MealType::EXTERNAL_RECIPE: {
                        auto external_recipe_meal_entry = schedule_day_meal_entry.external_recipe_meal();
                        day.add_meal(std::make_unique<core::schedule::ExternalRecipeMeal>(
                            external_recipe_meal_entry.meal().title(),
                            external_recipe_meal_entry.url(),
                            external_recipe_meal_entry.meal().servings(),
                            external_recipe_meal_entry.meal().comment()));
                        break;
                    }
                    case ::MealType::LEFTOVERS: {
                        auto leftovers_meal_entry = schedule_day_meal_entry.leftovers_meal();
                        day.add_meal(
                            std::make_unique<core::schedule::LeftoversMeal>(leftovers_meal_entry.meal().title(),
                                                                            leftovers_meal_entry.meal().servings(),
                                                                            leftovers_meal_entry.meal().comment()));
                        break;
                    }
                    case ::MealType::OTHER: {
                        auto external_recipe_meal_entry = schedule_day_meal_entry.other_meal();
                        day.add_meal(std::make_unique<core::schedule::LeftoversMeal>(
                            external_recipe_meal_entry.meal().title(),
                            external_recipe_meal_entry.meal().servings(),
                            external_recipe_meal_entry.meal().comment()));
                        break;
                    }
                    default:
                        return {grpc::StatusCode::ABORTED, "Invalid meal type in schedule"};
                }
            }
            schedule.add_day(std::move(day));
        }

        m_schedule_repository->add(std::move(schedule));
        schedule_id->set_schedule_id(id);
        return grpc::Status::OK;
    }

    grpc::Status update_recipe(grpc::ServerContext *context,
                               const UpdateRecipeRequest *request,
                               UpdateRecipeResponse *recipe_id) override {
        if (request->name().empty()) {
            return grpc::Status::CANCELLED;
        }

        std::vector<std::pair<Ingredient, std::optional<Quantity>>> ingredients;
        for (const auto &ingredient_entry : request->ingredients()) {
            const auto &quantity_entry = ingredient_entry.quantity();
            auto quantity =
                std::make_optional(Quantity{quantity_entry.amount(), static_cast<Unit>(quantity_entry.unit())});
            auto ingredient = m_ingredient_repository->find_by_id(ingredient_entry.id());
            if (!ingredient) {
                return {grpc::StatusCode::ABORTED, "Invalid ingredient ID in recipe"};
            }
            ingredients.emplace_back(ingredient.value(), quantity);
        }

        std::vector<std::string> steps(request->steps().size());
        std::copy(request->steps().begin(), request->steps().end(), steps.begin());

        m_recipe_repository->add(Recipe{request->id(),
                                        std::string(request->name()),
                                        static_cast<unsigned>(request->servings()),
                                        ingredients,
                                        steps});
        return grpc::Status::OK;
    }

    grpc::Status update_schedule(grpc::ServerContext *context,
                                 const UpdateScheduleRequest *request,
                                 UpdateScheduleResponse *schedule_id) override {
        Schedule schedule{request->id(), request->start_date()};
        for (const auto &day_entry : request->days()) {
            core::schedule::ScheduleDay day;
            for (const auto &meal_entry : day_entry.meals()) {
                switch (meal_entry.type()) {
                    case ::MealType::RECIPE: {
                        auto recipe_meal_entry = meal_entry.recipe_meal();
                        auto recipe = m_recipe_repository->find_by_id(recipe_meal_entry.recipe_id());
                        if (!recipe) {
                            return {grpc::StatusCode::ABORTED, "Invalid recipe ID in schedule"};
                        }
                        auto recipe_meal = std::make_unique<core::schedule::RecipeMeal>(
                            *recipe, recipe_meal_entry.meal().servings(), recipe_meal_entry.meal().comment());
                        day.add_meal(std::move(recipe_meal));
                    } break;
                    case ::MealType::EXTERNAL_RECIPE: {
                        auto external_recipe_meal_entry = meal_entry.external_recipe_meal();
                        auto external_recipe_meal = std::make_unique<core::schedule::ExternalRecipeMeal>(
                            external_recipe_meal_entry.meal().title(),
                            external_recipe_meal_entry.url(),
                            external_recipe_meal_entry.meal().servings(),
                            external_recipe_meal_entry.meal().comment());
                        day.add_meal(std::move(external_recipe_meal));
                        break;
                    }
                    case ::MealType::LEFTOVERS: {
                        auto leftovers_meal_entry = meal_entry.leftovers_meal();
                        auto leftovers_meal =
                            std::make_unique<core::schedule::LeftoversMeal>(leftovers_meal_entry.meal().title(),
                                                                            leftovers_meal_entry.meal().servings(),
                                                                            leftovers_meal_entry.meal().comment());
                        day.add_meal(std::move(leftovers_meal));
                        break;
                    }
                    case ::MealType::OTHER: {
                        auto other_meal_entry = meal_entry.other_meal();
                        auto other_meal =
                            std::make_unique<core::schedule::OtherMeal>(other_meal_entry.meal().title(),
                                                                        other_meal_entry.meal().servings(),
                                                                        other_meal_entry.meal().comment());
                        day.add_meal(std::move(other_meal));
                        break;
                    }
                    default:
                        return {grpc::StatusCode::ABORTED, "Invalid meal type in schedule"};
                }
            }
            schedule.add_day(std::move(day));
        }

        m_schedule_repository->add(std::move(schedule));
        return grpc::Status::OK;
    }

    grpc::Status erase_ingredient(grpc::ServerContext *context,
                                  const EraseIngredientRequest *request,
                                  EraseIngredientResponse *) override {
        m_ingredient_repository->erase(request->id());
        return grpc::Status::OK;
    }

    grpc::Status erase_recipe(grpc::ServerContext *context,
                              const EraseRecipeRequest *request,
                              EraseRecipeResponse *) override {
        m_recipe_repository->erase(request->id());
        return grpc::Status::OK;
    }

    grpc::Status erase_schedule(grpc::ServerContext *context,
                                const EraseScheduleRequest *request,
                                EraseScheduleResponse *) override {
        m_schedule_repository->erase(request->id());
        return grpc::Status::OK;
    }

    grpc::Status schedule_summary(grpc::ServerContext *context,
                                  const ScheduleSummaryRequest *request,
                                  ScheduleSummaryResponse *response) override {
        auto schedule = m_schedule_repository->find_by_id(request->id());
        if (!schedule) {
            return {grpc::StatusCode::ABORTED, "Invalid schedule ID"};
        }

        ::ScheduleSummaryResponse summary;
        for (const auto &ingredient_quantity_pair : schedule->summary().ingredients()) {
            auto ingredient = ingredient_quantity_pair.first;

            auto ingredient_entry = response->add_ingredients();
            ingredient_entry->set_id(ingredient.id());

            auto quantities = ingredient_quantity_pair.second;
            for (const auto &quantity : quantities) {
                auto quantity_entry = ingredient_entry->add_quantities();
                quantity_entry->set_amount(quantity->amount());
                quantity_entry->set_unit(static_cast<::Unit>(quantity->unit()));
            }
        }
        return grpc::Status::OK;
    }

    grpc::Status subscribe(grpc::ServerContext *context,
                           const SubscriptionRequest *request,
                           grpc::ServerWriter<SubscriptionResponse> *writer) override {
        auto status = grpc::Status::OK;
        m_subscribers.push_back(writer);
        while (true) {
            try {
                auto response = SubscriptionResponse();
                response.set_server_changed(false);
                if (!writer->Write(response)) {
                    m_subscribers.erase(std::remove(m_subscribers.begin(), m_subscribers.end(), writer),
                                        m_subscribers.end());
                    std::cout << "grpc: Connection with client lost, stopping "
                                 "subscription"
                              << std::endl;
                    status = grpc::Status::CANCELLED;
                    break;
                }

                std::this_thread::sleep_for(std::chrono::seconds(10));
            } catch (...) {
                break;
            }
        }

        return status;
    }

    void notify() override {
        auto response = SubscriptionResponse();
        response.set_server_changed(true);
        for (auto &subscriber : m_subscribers) {
            subscriber->Write(response);
        }
    }

private:
    std::shared_ptr<IngredientRepository> m_ingredient_repository;
    std::shared_ptr<RecipeRepository> m_recipe_repository;
    std::shared_ptr<ScheduleRepository> m_schedule_repository;
    std::shared_ptr<IdGenerator> m_id_generator;

    std::vector<grpc::ServerWriter<SubscriptionResponse> *> m_subscribers;
};

GrpcCommunicator::GrpcCommunicator(std::shared_ptr<IngredientRepository> ingredient_repository,
                                   std::shared_ptr<RecipeRepository> recipe_repository,
                                   std::shared_ptr<ScheduleRepository> schedule_repository,
                                   std::shared_ptr<IdGenerator> id_generator) :
m_ingredient_repository{std::move(ingredient_repository)},
m_recipe_repository{std::move(recipe_repository)},
m_schedule_repository{std::move(schedule_repository)},
m_id_generator{std::move(id_generator)} {}

void GrpcCommunicator::run() {
    std::string server_address("0.0.0.0:50051");
    Tabetai2Impl service(m_ingredient_repository, m_recipe_repository, m_schedule_repository, m_id_generator);

    grpc::ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);
    std::unique_ptr<grpc::Server> server(builder.BuildAndStart());
    std::cout << "grpc: Server listening on " << server_address << std::endl;
    server->Wait();
}

}  // namespace tabetai2::grpc_communicator
