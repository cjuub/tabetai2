#include <recipe/recipe.h>

namespace tabetai2::core::schedule {

class Meal {
public:
    Meal(recipe::Recipe recipe, unsigned servings);

    recipe::Recipe recipe() const;

    unsigned servings() const;

private:
    recipe::Recipe m_recipe;
    unsigned m_servings;
};

}
