import 'package:flutter/material.dart';
import '../models/product_details.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProduct = detailsProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MyShop',
            style: TextStyle(),
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          // SilverGridDelegate is used to describe the style and
          //layout of the grid and design it
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ProductItem(
            //passing data to Product_item widget
            loadedProduct[i].id,
            loadedProduct[i].title,
            loadedProduct[i].imageUrl,
          ),
          itemCount: loadedProduct.length,
        ));
  }
}
