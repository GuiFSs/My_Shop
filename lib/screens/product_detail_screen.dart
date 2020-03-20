import 'package:My_Shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    // if we don't pass listen: false, it'll re-run every time Products change
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
