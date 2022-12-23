//tool to convert data
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'product.dart';

//mixin class
class Products with ChangeNotifier {
  List<Product> _items = [
    //DUMMY DATA::
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  //var _showFavoritesOnly=false;

  //Auth Token::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  final String authToken;
  final String userId;

  Products(this.authToken,this.userId ,this._items);
  

  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem) =>prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoritesItems {
    
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //Fetch/get product from firebase::
  Future<void> fetchAndSetProducts([bool filterByUser=false]) async {
    //final filterString=filterByUser?'orderBy="creatorId"&equalTo="$userId"':'';
    var _params;
    if (filterByUser) {
      _params = <String, String>{
        'auth': authToken,
        'orderBy': json.encode("creatorId"),
        'equalTo': json.encode(userId),
      };
    }
    if (filterByUser == false) {
      _params = <String, String>{
        'auth': authToken,
      };
    }
    var url = Uri.https(
        'flutter-update-db0fa-default-rtdb.firebaseio.com', '/products.json',_params);
    //response that contain data:::
    try {
      final response = await http.get(url);
      //print(json.decode(response.body));
      //Map inside Map i.e Map<String,Map<String,String>>::
      //dart does not understand nested map ::
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData==null){
        return;
      }

      //fetching favourite item of the user......
      url = Uri.https('flutter-update-db0fa-default-rtdb.firebaseio.com',
        '/userFavourites/$userId.json',{'auth':'$authToken'});
      final favoriteResonse=await http.get(url);
      //this will be map:::::::::::::::::::::::::::::::::::::
      final favoriteData=json.decode(favoriteResonse.body);
      
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite:favoriteData==null?false:favoriteData[prodId] ?? false ,
            imageUrl: prodData['imageUrl']));
      });
      _items=loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //add product:::
  //asyncronous ..async will automatically wrap it into future::
  Future<void> addProduct(Product product) async {
    //url to which we send request::
    final url = Uri.https(
        'flutter-update-db0fa-default-rtdb.firebaseio.com', '/products.json',{'auth':'$authToken'});
    //future and async code:::
    //body contains data that gets attached to the request::
    //here dart once sends the request does not wait for responce and goes to the next line::
    //when we use .then() executes after getting responce and not immediatelly::
    //error by try and catch::
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'creatorId':userId
          }));
      //print(json.decode(response.body));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
    // .catchError((error){
    //   //Handling Error::
    //   print(error);
    //   throw error;
    // });
  }

//update product::::
  Future<void> updateProduct(String id, Product newProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
        'flutter-update-db0fa-default-rtdb.firebaseio.com', '/products/$id.json',{'auth':'$authToken'});
      await http.patch(url,body: json.encode({
        'title':newProduct.title,
        'description':newProduct.description,
        'imageUrl':newProduct.imageUrl,
        'price':newProduct.price
      }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

//delete product::::
  Future<void> deleteProduct(String id) async{
    final url = Uri.https(
        'flutter-update-db0fa-default-rtdb.firebaseio.com', '/products/$id.json',{'auth':'$authToken'});
    final existingProductIndex=_items.indexWhere((prod) => prod.id == id);
    var existingProduct=_items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
   final response=await http.delete(url);
      if(response.statusCode>=400){
         _items.insert(existingProductIndex, existingProduct);
          notifyListeners();
        throw HttpException('Could not delete product.');
      }
      //existingProduct=null;
    
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly=true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavoritesOnly=false;
  //   notifyListeners();
  // }

}
