import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  //const TabsScreen({Key? key}) : super(key: key);
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages ;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Your Favorite'}
  ];
    super.initState();
  }

//here flutter will automaticaly give the index of which tab is selected::::
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

 
  @override
  Widget build(BuildContext context) {
    //defaulttabcontroler will automatically identify which tab you tabed and will see result of that tab:::
    //u just need to tell which content to show for which tab::
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text('Meals'),
    //         bottom: TabBar(tabs: [
    //           //1st tab:::
    //           Tab(icon: Icon(Icons.category), text: 'Categories'),
    //           //2nd tab:::
    //           Tab(
    //             icon: Icon(Icons.favorite),
    //             text: 'Favorites',
    //           ),
    //         ]),
    //       ),
    //       //NOTE:here order of the tab matters:::
    //       body: TabBarView(children: [
    //         //1st tab load this screen::
    //         CategoriesScreen(),
    //         //2nd tab load this screen::
    //         FavoritesScreen()
    //       ]),
    //     ));

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      // hamburger icon-->drawer::
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        //it tell which tab is actually selected::::::
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites')
        ],
      ),
    );
  }
}
