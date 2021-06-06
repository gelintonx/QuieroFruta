import 'package:quiero_fruta/src/bloc/user_bloc.dart';
import 'package:quiero_fruta/src/utils/icon_color.dart';
import 'package:quiero_fruta/src/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: iconColor,
        backgroundColor: Colors.transparent,
      ),
      body: _CompleteUserPageBody(),
    );
  }
}

class _CompleteUserPageBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _rucCtrl = TextEditingController();
  final _adressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserBloc>(context);
    return Container(
        child: Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              child: TextFormField(
                controller: _nameCtrl,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Este campo no puede estar vacío'
                      : null;
                },
                decoration: InputDecoration(hintText: 'Nombre'),
              ),
            ),
            Container(
              width: 320,
              child: TextFormField(
                controller: _surnameCtrl,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Este campo no puede estar vacío'
                      : null;
                },
                decoration: InputDecoration(hintText: 'Apellido'),
              ),
            ),
            Container(
              width: 320,
              child: TextFormField(
                controller: _adressCtrl,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Este campo no puede estar vacío'
                      : null;
                },
                decoration: InputDecoration(hintText: 'Domicilio'),
              ),
            ),
            Container(
              width: 320,
              child: TextFormField(
                controller: _rucCtrl,
                validator: (String value) {
                  return value.isEmpty
                      ? 'Este campo no puede estar vacío'
                      : null;
                },
                decoration: InputDecoration(hintText: 'Ruc'),
              ),
            ),
            ElevatedButton(
              child: Text('Go'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  userProvider.addUser({
                    'name': _nameCtrl.text,
                    'surname': _surnameCtrl.text,
                    'ruc': _rucCtrl.text
                  });
                  navigate(context, '/');
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}
