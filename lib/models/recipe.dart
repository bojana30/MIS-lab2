class Recipe {
  int id;
  String name;
  String thumbnail;
  String instructions;
  List<String> ingredients;
  String link;

  Recipe({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
    required this.link,
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'thumbnail': thumbnail,
        'instructions': instructions,
        'ingredients': ingredients,
        'link': link,
      };

  Recipe.fromJson(Map<String, dynamic> data)
      : id = int.parse(data['idMeal']),
        name = data['strMeal'],
        instructions = data['strInstructions'],
        thumbnail = data['strMealThumb'],
        link = data['strSource'] ?? '',
        ingredients = _parseIngredients(data);

  static List<String> _parseIngredients(Map<String, dynamic> data) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i'];

      if (ingredient != null && ingredient
          .toString()
          .isNotEmpty && ingredient.toString() != '') {
        ingredients.add('$ingredient'.trim());
      }
    }

    return ingredients;
  }
}
