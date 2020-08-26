#include <yaml_database/yaml_ingredient_database.h>

#include <utility>
#include <fstream>

namespace tabetai2::yaml_database {

using namespace core::ingredient;

YamlIngredientDatabase::YamlIngredientDatabase(std::string database_file)
: m_database_file(std::move(database_file)),
  m_database(YAML::LoadFile(m_database_file)) {

}

void YamlIngredientDatabase::add(Ingredient ingredient) {
    auto entry = m_database["ingredients"][std::to_string(ingredient.id())];
    entry["id"] = ingredient.id();
    entry["name"] = ingredient.name();
    _commit_changes();
}

void YamlIngredientDatabase::erase(int id) {
    m_database["ingredients"].remove(std::to_string(id));
    _commit_changes();
}

Ingredient YamlIngredientDatabase::get(int id) const {
    auto entry = m_database["ingredients"][std::to_string(id)];
    return Ingredient(entry["id"].as<int>(), entry["name"].as<std::string>());
}

std::vector<Ingredient> YamlIngredientDatabase::get_all() const {
    std::vector<Ingredient> ingredients;
    for (const auto& entry : m_database["ingredients"]) {
        ingredients.emplace_back(entry.second["id"].as<int>(), entry.second["name"].as<std::string>());
    }

    return ingredients;
}

void YamlIngredientDatabase::_commit_changes() {
    std::ofstream fs;
    fs.open(m_database_file, std::ios::out);
    if (fs.is_open()) {
        fs << m_database;
        fs.close();
    }
}

}
