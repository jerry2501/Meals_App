import 'package:flutter/material.dart';

import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:200, // width
          childAspectRatio: 3/2, //  height/width ratio
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((catData)=>CategoryItem(
             catData.id,
            catData.title,
            catData.color
        )).toList(),
      );
  }
}
