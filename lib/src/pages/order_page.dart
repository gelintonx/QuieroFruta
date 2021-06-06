import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiero_fruta/src/services/login_service.dart';
import 'package:quiero_fruta/src/bloc/order_bloc.dart';
import 'package:quiero_fruta/src/utils/navigate.dart';
import 'package:quiero_fruta/src/widgets/product_card.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/img/fondo.png',
            fit: BoxFit.fill,
          )),
          _OrderPageBody()
        ],
      ),
    );
  }
}

class _OrderPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderBloc>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Haga su pedido', style: TextStyle(fontSize: 30)),
          Expanded(
            child: ListView.builder(
              itemCount: orderProvider.productsCard.length,
              itemBuilder: (_, int i) {
                final product = orderProvider.productsCard[i];
                return ProductCard(
                  productId: product['id'],
                  name: product['name'],
                  img: product['img'],
                  add: product['add'],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final loginService = LoginService();
                  final response = await loginService.checkLoggedIn();
                  response
                      ? navigate(context, '/confirm-order')
                      : navigate(context, '/login');
                },
                child: Text('Pedir'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
