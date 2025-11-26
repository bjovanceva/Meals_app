import 'package:flutter/material.dart';
import 'package:lab2_221059/models/mealDetails_model.dart';

import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/recipe_details.dart';
import '../widgets/recipe_image.dart';
import '../widgets/recipe_title.dart';
// import '../widgets/detail_image.dart';
// import '../widgets/detail_title.dart';
// import '../widgets/detail_data.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>{

  late Meal meal;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();
  MealDetails? _mealDetails;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only load once
    if (!_isLoading) return;

    meal = ModalRoute.of(context)!.settings.arguments as Meal;
    _loadMealDetails();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _mealDetails == null
          ? const Center(child: Text("No recipe found"))
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RecipeImage(image: _mealDetails?.image),
            const SizedBox(height: 20),
            RecipeTitle(name: _mealDetails?.name),
            const SizedBox(height: 20),
            RecipeDetails(mealDetails: _mealDetails),
          ],
        ),
      ),
    );
  }


  void _loadMealDetails() async{
    final mealDetails = await _apiService.loadMealDetails(meal.id);

    setState(() {
      _mealDetails = mealDetails;
      _isLoading = false;
    });
  }
}
