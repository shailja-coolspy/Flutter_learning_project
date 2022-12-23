import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({Key? key}) : super(key: key);

  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    //here if we make listener false then this build will not listen change notifier and will not update but only update in background::
    //on using final product whole widget rebuild when some thing changes
    final product = Provider.of<Product>(context,
        listen: false); //use this syntax or consumer syntax
    final cart =Provider.of<Cart>(context,listen: false);
    //Auth data::::::::::::
    final authData=Provider.of<Auth>(context,listen: false);
    //print('product rebuild');
    //clipRRect forces child widget to get in certain shape::
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //In consumer we can make only subpart of widget rebuild and
          //in consumer builder child contain widget that not need to be rebuild/update::
          //since we only want to rebuild favorite part change::
          //"_" as we do not require child here
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus(authData.token as String,authData.userId as String);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id as String, product.price, product.title);
              //msg on adding item to card::
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(label: 'UNDO', onPressed:(){
                  cart.removeSingleItem(product.id as String);
                }),
                ));
            },
          ),
        ),
      ),
    );
  }
}
