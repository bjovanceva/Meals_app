import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2_221059/models/mealDetails_model.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class ApiService{
  Future<List<Category>> loadCategories() async {
    List<Category> categories = [];

      final detailResponse = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
      );

      if (detailResponse.statusCode == 200) {
          final data = json.decode(detailResponse.body);
          final List list = data["categories"];

          categories =
          list.map((json) => Category.fromJson(json)).toList();
    }

    return categories;
  }


  Future<List<Meal>> loadMealsByCategory(String name) async {
    List<Meal> meals = [];
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=${name.toLowerCase()}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List list = data["meals"];

        meals =
            list.map((json) => Meal.fromJson(json)).toList();


      }
      return meals;

  }



  Future<MealDetails?> loadMealDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final meals = data["meals"];
        if (meals == null || meals.isEmpty) {
          return null;
        }

        return MealDetails.fromJson(meals[0]);
      } else {
        throw Exception('Failed to load meal details: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }


  Future<Meal?> loadRandomMeal() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'];
      return list.map((json) => Meal.fromJson(json)).toList()[0];
    }
    return null;
  }

}
