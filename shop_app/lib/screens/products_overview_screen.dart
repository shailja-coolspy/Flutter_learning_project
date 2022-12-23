import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/products.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isInit=true;
  var _isLoading=false;
  @override
  void initState() {
    //get request:::
    //Provider.of<Products>(context).fetchAndSetProducts();//WON'T WORK HERE
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
      if(_isInit){
        setState(() {
          _isLoading=true;
        });
           Provider.of<Products>(context).fetchAndSetProducts().then((_){
            setState(() {
              _isLoading=false;
            });
           });
      }
      //so it does not run again::
      _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //final productContainer=Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          //menu opens that is overlay
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              //print(selectedValue);
              //set state to reflect change data in ui::
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  //productContainer.showFavoritesOnly();
                  _showFavoritesOnly = true;
                } else {
                  //productContainer.showAll();
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>Badge(
                child: ch!, 
                value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:_isLoading?Center(
        child: CircularProgressIndicator(),
      ) :ProductsGrid(_showFavoritesOnly),
    );
  }
}
