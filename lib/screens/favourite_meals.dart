import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2_221059/widgets/meal_grid.dart';

import '../models/meal_model.dart';
import '../widgets/meal_card.dart';

class FavouriteMealsPage extends StatelessWidget {
  final List<Meal> meals;

  const FavouriteMealsPage({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite Meals")),
      body: MealGrid(meals: meals,),
    );
  }
}