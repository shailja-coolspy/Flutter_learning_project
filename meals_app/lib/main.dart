import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //filter management::
  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favoriteMeals=[];

  void _setFilters(Map<String,bool> filterData){
      setState(() {
        _filters=filterData;
        _availableMeals=DUMMY_MEALS.where((meal){
          if(_filters['gluten']! && !meal.isGlutenFree){
            return false;
          }
          if(_filters['lactose']! && !meal.isLactoseFree){
            return false;
          }
          if(_filters['vegan']! && !meal.isVegan){
            return false;
          }
          if(_filters['vegetarian']! && !meal.isVegetarian){
            return false;
          }

          return true;
        }).toList();
      });
  }

  //add item to favorite::
   void _toggleFavourite(String mealId){
    final existingIndex=_favoriteMeals.indexWhere((meal) =>meal.id == mealId );

    if(existingIndex>=0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) =>meal.id == id);
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        //.copyWith() to replace default theme setting ->by our theme setting(custom setting)
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1:TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          headline6:TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',//default is '/'::
      //registration of routes::::::::::::note::::::::::
      routes: {
        //this is default route for home::
        '/':(ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName:(ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName:(ctx)=>MealDetailScreen(_toggleFavourite,_isMealFavorite),
        //passing pointer::
        FilterScreen.routeName:(ctx) => FilterScreen(_filters,_setFilters)
      },
      //exectue if no registered route is found in route table
      onGenerateRoute: (settings) {
        print(settings.arguments);
        //if router/navigating screen is not found i.e which screen/page to navigate(on tap) in then it will direct to categories screen page:::
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);

      },
      //unknowmroute is reached when flutter fail to build a page with other measure(routes,ongenerateroute)i.e fall back...it is like 404 in web::::
      onUnknownRoute: (settings) {
                return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);

      },
    );
  }
}

