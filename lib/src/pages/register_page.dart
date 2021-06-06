import 'dart:io';
import 'package:quiero_fruta/src/utils/navigate.dart';
import '../bloc/register_bloc.dart';
import '../services/register_service.dart';
import '../utils/email_regular_expression.dart';
import '../utils/icon_color.dart';
import '../utils/navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController(text: '+595');
  final _passwordCtrl = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneNumberCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void toggle(bool x) {
    setState(() {
      _obscureText = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: iconColor,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 320,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailCtrl,
                    validator: (String value) {
                      return value.isEmpty
                          ? 'Este campo no puede estar vacío'
                          : checkEmail(value)
                              ? null
                              : 'Este email no es válido';
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberCtrl,
                    validator: (String value) {
                      return value.contains('+595') ? null : null;
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                ),
                Container(
                  width: 320,
                  child: TextFormField(
                    obscureText: _obscureText,
                    controller: _passwordCtrl,
                    validator: (String value) {
                      return value.isEmpty
                          ? 'Este campo no puede estar vacío'
                          : value.length < 8
                              ? 'La contraseña debe contener almenos 8 carácteres'
                              : null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Contraseña',
                        suffixIcon: IconButton(
                          icon: _obscureText
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            _obscureText ? toggle(false) : toggle(true);
                          },
                        )),
                  ),
                ),
                ElevatedButton(
                    child: Text('Go'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final registerService = RegisterService();
                        final response = await registerService.signUp(
                            _emailCtrl.text,
                            _passwordCtrl.text,
                            _phoneNumberCtrl.text);
                        if (Platform.isIOS) {
                          if (response == false) {
                            provider.authData(_emailCtrl.text);
                            navigate(context, '/confirmation');
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                        'Ha ocurrido un error en el proceso de registro.\nIntentelo de nuevo'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                          }
                        } else {
                          if (response == true) {
                            provider.authData(_emailCtrl.text);
                            navigate(context, '/confirmation');
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                        'Ha ocurrido un error en el proceso de registro'),
                                    content: Text(
                                        response), // TODO: Add translation to this log,
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
