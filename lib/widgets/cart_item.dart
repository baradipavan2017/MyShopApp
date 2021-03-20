import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  CartItem(this.id, this.price, this.quantity, this.title, this.productId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      //Creating an alert dialouge box using the direction
      confirmDismiss: (direction) {
        //should return a future value such as flse or true
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you Sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: <Widget>[
              TextButton(
                  // returning false and closing the alert dialouge
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No')),
              TextButton(
                  //returning true and deleting the dismissial
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text('Yes')),
            ],
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                    child: Text(
                  '\$$price',
                  // style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity  X'),
          ),
        ),
      ),
    );
  }
}
