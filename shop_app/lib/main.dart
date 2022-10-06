import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import './providers/Cart.dart';
import './providers/orders.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //it means we can listen products and cart from anywhere in the application::
      providers: [
        ChangeNotifierProvider(create: (ctx) =>Products()),
      ChangeNotifierProvider(create:((ctx) => Cart() )),
      ChangeNotifierProvider(create: (ctx) => Orders(),)
    ] ,
      //value: Products(), 
      child: MaterialApp(
        title: 'MyShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(   
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName:(ctx) => ProductDetailScreen(),
          CartScreen.routeName:(ctx) => CartScreen(),
          OrdersScreen.routeName:(ctx) => OrdersScreen()
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
 
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body:Center(
//         child:Text('lets build shop app'),
//       ),
//     );
//   }
// }
