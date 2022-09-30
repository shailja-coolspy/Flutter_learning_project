import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  //const ProductDetailScreen({Key? key}) : super(key: key);

  static const routeName='/product-detail';
  

  @override
  Widget build(BuildContext context) {
    //is the id
    final productId=ModalRoute.of(context)!.settings.arguments as String;

    //product data for that id::
    

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}