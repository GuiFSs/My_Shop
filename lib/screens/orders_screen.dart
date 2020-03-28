import 'package:My_Shop/providers/orders.dart' show Orders;
import 'package:My_Shop/widgets/app_drawer.dart';
import 'package:My_Shop/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (dataSnapshot.error != null) {
            // Do error handling stuff
          } else if (dataSnapshot.connectionState == ConnectionState.done) {
            return Consumer<Orders>(
              builder: (ctx, orderData, child) {
                return ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) {
                    final order = orderData.orders[i];
                    return OrderItem(order);
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
