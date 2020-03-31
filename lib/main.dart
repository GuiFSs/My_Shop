import 'package:My_Shop/providers/auth.dart';
import 'package:My_Shop/providers/cart.dart';
import 'package:My_Shop/providers/orders.dart';
import 'package:My_Shop/screens/auth_screen.dart';
import 'package:My_Shop/screens/cart_screen.dart';
import 'package:My_Shop/screens/edit_product_screen.dart';
import 'package:My_Shop/screens/orders_screen.dart';
import 'package:My_Shop/screens/product_detail_screen.dart';
import 'package:My_Shop/screens/splash_screen.dart';
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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, [], null),
          update: (_, auth, previousProducts) => Products(
            auth.token,
            previousProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(null, [], null),
          update: (_, auth, previous) => Orders(
            auth.token,
            previous.orders,
            auth.userId,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    return AuthScreen();
                  },
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
