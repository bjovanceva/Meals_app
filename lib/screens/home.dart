import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab2_221059/screens/recipe.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';
import '../widgets/category_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _categories = [];
  List<Category> _filtered = [];
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Categories"),
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
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: _filterCategories,
              decoration: InputDecoration(
                hintText: "Search category...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Grid list
          Expanded(
            child: CategoryGrid(categories: _filtered),
          ),
        ],
      ),
    );
  }


  void _loadCategories() async {

    final categories = await _apiService.loadCategories();
      setState(() {
        _categories = categories;
        _filtered = categories;
        _isLoading = false;
      });
    }
  //}


  void _filterCategories(String query) {
    final q = query.toLowerCase();

    setState(() {
      _filtered = _categories
          .where((c) => c.name.toLowerCase().contains(q))
          .toList();
    });
  }
}