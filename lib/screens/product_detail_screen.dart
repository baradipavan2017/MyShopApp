import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // ProductDetailScreen(this.title);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // extracting the id from the namedRoute to productId
    final productId = ModalRoute.of(context).settings.arguments as String;
    //findby logic can be hidden in provider class
   // changind the listner to flase in buildcontext it dosent not access data everytime
   // i.e. increase in performance
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
