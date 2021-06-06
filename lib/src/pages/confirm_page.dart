import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiero_fruta/src/bloc/login_bloc.dart';
import 'package:quiero_fruta/src/bloc/register_bloc.dart';
import 'package:quiero_fruta/src/services/login_service.dart';
import 'package:quiero_fruta/src/services/register_service.dart';
import 'package:quiero_fruta/src/utils/icon_color.dart';
import 'package:quiero_fruta/src/utils/navigate.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: iconColor,
      ),
      body: _ConfirmationPageBody(),
    );
  }
}

class _ConfirmationPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterBloc>(context);
    final loginProvider = Provider.of<LoginBloc>(context);
    final _confirmationCodeCtrl = TextEditingController();

    return Center(
        child: Form(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 320,
            child: TextFormField(
              autofocus: true,
              controller: _confirmationCodeCtrl,
              decoration: InputDecoration(hintText: 'Código de verificación'),
            )),
        ElevatedButton(
            child: Text('Go'),
            onPressed: () async {
              final register = RegisterService();
              final login = LoginService();

              if (loginProvider.isCompleted == false) {
                final response =
                    await login.confirmSignIn(_confirmationCodeCtrl.text);
                response
                    ? navigate(context, '/order')
                    : print('Error en la confirmación');
              } else {
                final response = await register.confirmSignUp(
                    registerProvider.email, _confirmationCodeCtrl.text);
                response
                    ? navigate(context, '/complete-user')
                    : print('Error en la confirmación');
              }
            })
      ],
    )));
  }
}
