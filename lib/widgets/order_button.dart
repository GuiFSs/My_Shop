import 'package:My_Shop/providers/cart.dart';
import 'package:My_Shop/providers/orders.dart';
import 'package:My_Shop/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  Future<void> _addOrder() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Orders>(context, listen: false).addOrder(
        widget.cart.items.values.toList(),
        widget.cart.totalAmount,
      );
      widget.cart.clear();
      Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
    } catch (err) {
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed:
          (widget.cart.totalAmount <= 0 || _isLoading) ? null : _addOrder,
    );
  }
}
