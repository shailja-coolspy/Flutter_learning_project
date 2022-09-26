import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  
  //const CategoryItem({Key? key}) : super(key: key);
  final String id;
  final String title;
  final Color color;
  CategoryItem(this.id, this.title, this.color);

  //selectCategory item run inside single category item so we can pass (id,title):::
  void selectCategory(BuildContext ctx) {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return CategoryMealsScreen(id,title);
    // },));

    Navigator.of(ctx)
        .pushNamed(CategoryMealsScreen.routeName, arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    //gesturedetector() allows "on tap,doubletap etc" and other gestures
    //but here we will use inkwell() as it has ripple effect like(wave coming out when u tap it)
    return InkWell(
      onTap: () => selectCategory(context),
      //ripple effect
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.headline6),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color.withOpacity(0.7),
              color,
            ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
