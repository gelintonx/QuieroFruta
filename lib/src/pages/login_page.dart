import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiero_fruta/src/bloc/login_bloc.dart';
import 'package:quiero_fruta/src/services/login_service.dart';
import 'package:quiero_fruta/src/utils/colors.dart';
import 'package:quiero_fruta/src/utils/email_regular_expression.dart';
import 'package:quiero_fruta/src/utils/navigate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void toggle(bool x) {
    setState(() {
      _obscureText = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/app_logo.png',
                  width: 220,
                ),
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
                    obscureText: _obscureText,
                    controller: _passwordCtrl,
                    validator: (String value) {
                      return value.isEmpty
                          ? 'Este campo no puede estar vacío'
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
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final loginService = LoginService();
                        final response = await loginService.signIn(
                            _emailCtrl.text, _passwordCtrl.text);
                        if (response == false) {
                          loginProvider.authData(response);
                          navigate(context, '/confirmation');
                        } else {
                          print(response);
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      'Ha ocurrido un error en el proceso de registro.\nIntentelo de nuevo'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK')),
                                  ],
                                );
                              });
                        }
                      }
                    },
                    child: Text('Go')),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () => navigate(context, '/register'),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Aún no dispones de una cuenta? ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(text: 'Crea una', style: TextStyle(color: green))
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
