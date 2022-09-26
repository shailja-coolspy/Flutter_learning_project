import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meals_app/widgets/category_item.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  //const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map((catData) => CategoryItem(catData.id, catData.title, catData.color))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
      );
    
  }
}
