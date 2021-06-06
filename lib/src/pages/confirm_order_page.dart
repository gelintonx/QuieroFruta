import 'package:flutter/material.dart';
import 'package:quiero_fruta/src/bloc/order_bloc.dart';
import 'package:quiero_fruta/src/bloc/user_bloc.dart';
import 'package:quiero_fruta/src/utils/icon_color.dart';
import 'package:provider/provider.dart';
import 'package:quiero_fruta/src/utils/navigate.dart';
import 'package:smart_select/smart_select.dart';
import 'package:cool_alert/cool_alert.dart';

class ConfirmOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<S2Choice<String>> options = [
      S2Choice(value: '1', title: 'Carry Out'),
      S2Choice(value: '3', title: 'Delivery')
    ];

    String value = '1';

    final orderProvider = Provider.of<OrderBloc>(context);
    final userProvider = Provider.of<UserBloc>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: iconColor,
          backgroundColor: Colors.transparent,
          title: Text(
            'Confirmar pedido',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Importe total: ${orderProvider.totalPrice} \u20B2'),
              ),
              FutureBuilder(
                  future: userProvider.phoneNumber,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data);
                    } else {
                      return Container();
                    }
                  }),
              SmartSelect<String>.single(
                  title: 'Selecciona una opción',
                  value: value.toString(),
                  choiceItems: options,
                  onChange: (state) {
                    value = state.value;
                  }),
              ElevatedButton(
                  onPressed: () async {
                    final response = await orderProvider.confirmOrder(value);
                    if (response['status'] == 200) {
                      await CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          widget: Image.asset('assets/img/app_logo.png'),
                          text: 'Su pedido ha sido completado con éxito');
                      orderProvider.deleteCart();
                      navigate(context, '/');
                    } else {
                      CoolAlert.show(
                          context: context, type: CoolAlertType.error);
                    }
                  },
                  child: Text('Confirmar pedido'))
            ],
          ),
        ));
  }
}
