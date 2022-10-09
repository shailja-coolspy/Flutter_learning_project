import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../providers/Cart.dart';

class CartItem extends StatelessWidget {
  //const CartItem({Key? key}) : super(key: key);
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      //dialog box::
      confirmDismiss: (direction) {
        //scaffold is not required here as it is not attached to page::
        //builder give there own context::note::
        return showDialog(context: context, builder: (ctx) =>AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from the cart?'),
          actions: [
            FlatButton(onPressed: () {
              Navigator.of(ctx).pop(false);
            }, child: Text('No')),
            FlatButton(onPressed: () {
              Navigator.of(ctx).pop(true);
            }, child: Text('Yes'))
          ],
        ) ,);
      },
      //on dismiss function::
      onDismissed: (direction) {
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text('\R$price'),
                    ))),
            title: Text(title),
            subtitle: Text('Total: \Rs${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
