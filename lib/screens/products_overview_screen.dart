import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  // final List<Product> loadedProduct = detailsProducts;

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnluFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
          style: TextStyle(),
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnluFavorites = true;
                } else {
                  _showOnluFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Onlu Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: new ProductGrid(_showOnluFavorites),
    );
  }
}
