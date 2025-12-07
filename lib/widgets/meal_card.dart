import 'package:flutter/material.dart';

import '../models/meal_model.dart';
import '../screens/favourite_meals.dart';
import '../screens/meal_by_category.dart';
import 'favourites.dart';



class MealCard extends StatelessWidget{

  final Meal meal;


  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/recipe", arguments: meal);
      },
      child: Card(

        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 13),
                  Image(image: NetworkImage(meal.img),
                    width: 150,
                    height: 150,
                  )
                ],
              ),

              SizedBox(height: 3,),

              const Divider(),

              SizedBox(height: 3,),

              Row(
                children: [
                  const Icon(Icons.title, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(child:
                  Text(
                    meal.name.length > 15
                        ? '${meal.name.substring(0, 15)}...'
                        : meal.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.redAccent
                    ),
                  ),
                  ),
                ],
              ),

              SizedBox(height: 6),

              if (!favouriteMeals.contains(meal))
              Row(
                children: [
                  const SizedBox(width: 6),
                  Expanded(child:
                  ElevatedButton(
                      onPressed: () {favouriteMeals.add(meal);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouriteMealsPage(meals: favouriteMeals),
                        ),
                      );},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.lightGreen),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                      child: Text('Add to favourites'),),
                  ),
                ],
              ),







            ],
          ),
        ),
      ),
    );

  }

}