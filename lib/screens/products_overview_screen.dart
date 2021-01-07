import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';



class ProductOverviewScreen extends StatelessWidget {
  // final List<Product> loadedProduct = detailsProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
          style: TextStyle(),
        ),
      ),
      body: new ProductGrid(),
    );
  }
}
