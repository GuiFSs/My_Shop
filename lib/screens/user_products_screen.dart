import 'package:My_Shop/providers/products.dart';
import 'package:My_Shop/screens/edit_product_screen.dart';
import 'package:My_Shop/widgets/app_drawer.dart';
import 'package:My_Shop/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    void deleteProduct(String id) {
      productsData.deleteProduct(id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (ctx, index) {
            final product = productsData.items[index];
            return Column(
              children: <Widget>[
                UserProductItem(
                    product.id, product.title, product.imageUrl, deleteProduct),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
