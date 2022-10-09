import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  //const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName='/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yours Product'),
        actions: [
          //add new product
          IconButton(onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: 'newProduct');
          }, icon:const Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children:[ UserProductItem(
                productsData.items[i].id as String,
                productsData.items[i].title, 
                productsData.items[i].imageUrl),
                Divider(),
                ],

          ),
        ),
      ),
    );
  }
}
