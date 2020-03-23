import 'package:My_Shop/providers/cart.dart';
import 'package:My_Shop/providers/orders.dart';
import 'package:My_Shop/screens/cart_screen.dart';
import 'package:My_Shop/screens/edit_product_screen.dart';
import 'package:My_Shop/screens/orders_screen.dart';
import 'package:My_Shop/screens/product_detail_screen.dart';
import 'package:My_Shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import './screens/produtcs_overview_screen.dart';
import 'package:flutter/material.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
