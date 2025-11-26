class MealDetails {
  final String id;
  final String name;
  final String instructions;
  final String image;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;

  MealDetails({
    required this.id,
    required this.name,
    required this.instructions,
    required this.image,
    this.youtube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 0; i < 20; i++) {
      final ing = json["strIngredient$i"];
      final meas = json["strMeasure$i"];

      if (ing != null && ing.toString().trim().isNotEmpty) {
        ingredients.add(ing);
        measures.add(meas ?? "");
      }
    }

    return MealDetails(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      image: json['strMealThumb'],
      youtube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}










