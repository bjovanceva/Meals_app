import 'package:lab2_221059/widgets/category_card.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';



class CategoryGrid extends StatefulWidget{
  final List<Category> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();


}

class _CategoryGridState extends State<CategoryGrid>{

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
              childAspectRatio: 170 / 230
          ),
          itemCount: widget.categories.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return CategoryCard(category: widget.categories[index]);
          },
        ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text("Total categories: ${widget.categories.length}", style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold,
          ),
          ),
        )
      ],
    );


  }

}