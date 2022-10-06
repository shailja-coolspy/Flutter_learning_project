import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {

    //Note::::::
    final productsData = Provider.of<Products>(context);
    //if showFavs is true the favoritesItems or else items::
    final products = showFavs? productsData.favoritesItems:productsData.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        //how many colum:::
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        //use .value in existing object when we reuse::
        //change notifier provider cleans the old data/replacement automatically 
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          //create:(c)=>products[i],
          value: products[i],
          child: ProductItem(
            // products[i].id,
            //   products[i].title, 
            //   products[i].imageUrl
            ),
        ));
  }
}
