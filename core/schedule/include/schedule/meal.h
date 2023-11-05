#include <recipe/recipe.h>

namespace tabetai2::core::schedule {

class Meal {
public:
    Meal(recipe::Recipe recipe, unsigned servings, bool is_leftovers, std::string comment);

    recipe::Recipe recipe() const;

    unsigned servings() const;

    bool is_leftovers() const;

    std::string comment() const;

private:
    recipe::Recipe m_recipe;
    unsigned m_servings;
    bool m_is_leftovers;
    std::string m_comment;
};

}
