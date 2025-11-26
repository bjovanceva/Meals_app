import 'package:flutter/material.dart';

import '../models/category_model.dart';



class CategoryCard extends StatelessWidget{

  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/meals", arguments: category.name);
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
                  const Icon(Icons.category, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(child:
                  Text(
                    category.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent
                    ),
                  ),
                  ),
                ],
              ),

              const Divider(),


              Row(
                children: [
                  const SizedBox(width: 40),
                  Image(image: NetworkImage(category.img),
                    width: 100,
                    height: 100,
                  )
                ],
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.description, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      maxLines: 5,
                      category.description,
                      style: const TextStyle(fontSize: 12),
                    ),
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