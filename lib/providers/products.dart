import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myshop/models/http_exeception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //using async and await
  Future<void> addProduct(Product product) async {
    //initializing the url with /product folder
    const url =
        'https://myshop-d6854-default-rtdb.firebaseio.com/products.json';
    //try catch block to find errors
    try {
      //post is to store data in server
      // await is assigned o repsonse which works similar to then and catch
      final response = await http.post(
        url,
        //encoding it in json format
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      //to know whats in the response
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); //to insert product at a given value
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

//updating the product from edit screen
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      //updating the product using patch using id of the product
      final url =
          'https://myshop-d6854-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'descrption': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://myshop-d6854-default-rtdb.firebaseio.com/products/$id.json';
    //optimistic deletingn
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    // from server
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      //code for error thrown
      throw HttpException('Could not Delete the Product');
    }
    existingProduct = null;
  }

  //fetching data from the server
  Future<void> fetchAndSetProducts() async {
    const url =
        'https://myshop-d6854-default-rtdb.firebaseio.com/products.json';
    try {
      //getting the data from url
      final response = await http.get(url);
      //extrating data from the map
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      //converting dynamic data to lists
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData["title"],
          description: prodData["description"],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      // initiating loaded data to items
      _items = loadedProducts;
      notifyListeners();
      //to know hows it returns the values from server
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
