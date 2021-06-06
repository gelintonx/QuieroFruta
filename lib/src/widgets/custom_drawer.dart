import 'package:amplify_flutter/amplify.dart';
import 'package:quiero_fruta/src/device/save_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/navigate.dart';
import 'package:flutter/material.dart';

class ArasaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = SaveUser();
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
                title: FutureBuilder(
              future: user.getName(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.data != null
                    ? Text('Bienvenido ${snapshot.data}')
                    : Text('Haz tu primer pedido');
              },
            )),
            ListTile(
              onTap: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              title: Text('Inicio'),
              trailing: Icon(Icons.home, color: Color(0xFF772953)),
            ),
            ListTile(
                onTap: () => navigate(context, '/choose'),
                title: Text('Añadir Sucursal'),
                trailing: Icon(Icons.add, color: Color(0xFF772953))),
            /*ListTile(
                onTap: () => null,
                title: Text('Repetir pedido anterior'),
                trailing: Icon(Icons.repeat, color: Color(0xFF772953))),*/
            ListTile(
              onTap: () async {
                await Amplify.Auth.signOut();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                final snackbar = SnackBar(
                  content: Text('Su sesión ha sido cerrada'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
              title: Text('Cerrar Sesión'),
              trailing: Icon(Icons.logout, color: Color(0xFF772953)),
            ),
            Center(child: Image.asset('assets/img/app_logo.png', height: 100, width: 100,))
          ],
        ),
      ),
    );
  }
}
