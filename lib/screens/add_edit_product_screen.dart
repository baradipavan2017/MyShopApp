import 'package:flutter/material.dart';

class AddEditProductScreen extends StatefulWidget {
  static const routeName = '/add-edit-product-screen';
  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  //creating focus node
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                // when pressed enter the focus changes to the price
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                //focus target
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
