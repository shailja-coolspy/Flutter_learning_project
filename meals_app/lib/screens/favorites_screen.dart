import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);


  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return Center(child: Text('You have no favorite yet - start adding some!'),);
    }else{
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: favoriteMeals[index].title,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              duration: favoriteMeals[index].duration,
              imageUrl: favoriteMeals[index].imageUrl,
              id: favoriteMeals[index].id,
              
            );
          },
          itemCount: favoriteMeals.length,
        );
    }
  }
}