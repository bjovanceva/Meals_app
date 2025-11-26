import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab2_221059/screens/recipe.dart';
import 'package:lab2_221059/widgets/meal_grid.dart';

import '../models/meal_model.dart';
import '../services/api_service.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  List<Meal> _meals = [];
  List<Meal> _filtered = [];
  bool _isLoading = true;
  late String category;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only load once
    if (!_isLoading) return;

    category = ModalRoute.of(context)!.settings.arguments as String;
    _loadMeals();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.smart_button_outlined),
            label: const Text("Random Recipe"),
            onPressed: () async {
              final randomMeal = await ApiService().loadRandomMeal();
              if (randomMeal != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipePage(),
                    settings: RouteSettings(arguments: randomMeal),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: _searchMeals,
              decoration: InputDecoration(
                hintText: "Search meals by selected category...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Grid list
          Expanded(
            child: MealGrid(meals: _filtered),
          ),
        ],
      ),
    );
  }


  void _loadMeals() async {
    final meals = await _apiService.loadMealsByCategory(category);

      setState(() {
        _meals = meals;
        _filtered = meals;
        _isLoading = false;
      });
    }



  void _searchMeals(String query) async {
    final q = query.toLowerCase();

    final url = "https://www.themealdb.com/api/json/v1/1/search.php?s=${q}";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data["meals"];

      if (data["meals"] == null) {
        setState(() => _filtered = []);
        return;
      }


      List<Meal> filtered = [];
      var el;
      for(el in list){
        if(el['strCategory'] != null && el['strCategory'] == category){
          filtered.add(Meal.fromJson(el));
        }
      }


      setState(() {
        _filtered = filtered;

      });
    }
  }
}