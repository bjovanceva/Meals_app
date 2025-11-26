import 'package:lab2_221059/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:lab2_221059/widgets/meal_card.dart';

import '../models/meal_model.dart';



class MealGrid extends StatefulWidget{
  final List<Meal> meals;

  const MealGrid({super.key, required this.meals});

  @override
  State<StatefulWidget> createState() => _MealGridState();


}

class _MealGridState extends State<MealGrid>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child:
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 160 / 230
          ),
          itemCount: widget.meals.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return MealCard(meal: widget.meals[index]);
          },
        ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("Total meals: ${widget.meals.length}", style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold,
          ),
          ),
        )
      ],
    );


  }

}