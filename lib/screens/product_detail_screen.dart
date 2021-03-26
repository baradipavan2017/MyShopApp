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
      body: CustomScrollView(
        slivers: <Widget>[
          //app bar should contain an image and title 
          // which will we converted to app bar title
          // image will shrink away
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // containsa all the necessary details
          // they scroll and expand
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 40,
                ),
                Text(
                  '\$${loadedProduct.price}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
