import 'package:My_Shop/providers/orders.dart' show Orders;
import 'package:My_Shop/widgets/app_drawer.dart';
import 'package:My_Shop/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) {
          final order = orderData.orders[i];
          return OrderItem(order);
        },
      ),
    );
  }
}
