#pragma once

#include <recipe/recipe_repository.h>
#include <schedule/schedule.h>

#include <yaml_database/yaml_database.hpp>

namespace tabetai2::yaml_database {

class YamlScheduleDatabase : public YamlDatabase<core::schedule::Schedule> {
public:
    YamlScheduleDatabase(std::string database_file,
                         std::string database_name,
                         std::shared_ptr<core::recipe::RecipeRepository> recipe_repository);

    core::schedule::Schedule from_yaml(YAML::Node entry) const override;

    YAML::Node to_yaml(const core::schedule::Schedule& schedule) const override;

private:
    std::shared_ptr<core::recipe::RecipeRepository> m_recipe_repository;
};

}  // namespace tabetai2::yaml_database
