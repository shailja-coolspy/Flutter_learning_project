//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;
  String? categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData=false;
//this will automatically run when build run the first time:::::
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //extract route argument::
    if(_loadedInitData==false){
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    //it checks categories to which meal belong.....
    displayedMeals = widget.availableMeals.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    _loadedInitData=true;
    }
    super.didChangeDependencies();
  }

//remove item from list ....Note:::
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle!)),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: displayedMeals[index].title,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
              duration: displayedMeals[index].duration,
              imageUrl: displayedMeals[index].imageUrl,
              id: displayedMeals[index].id,
              //removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
