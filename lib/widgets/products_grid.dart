import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    //providing the data to grid using listner
    final productsData = Provider.of<Products>(context);
    // to check for data favorite or not
    final products = showFavs ? productsData.favoriteItems : productsData.items;
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
      // using .value can help to reduce the code
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (ctx) =>products[i],
        value: products[i],
        child: ProductItem(
            //passing data to Product_item widget
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      itemCount: products.length,
    );
  }
}
