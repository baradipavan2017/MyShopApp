import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

import './product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //providing the data to grid using listner
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
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
        products[i].id,
        products[i].title,
        products[i].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
