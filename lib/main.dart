import 'package:quiero_fruta/src/bloc/login_bloc.dart';
import 'package:quiero_fruta/src/bloc/order_bloc.dart';
import 'package:quiero_fruta/src/bloc/products_bloc.dart';
import 'package:quiero_fruta/src/bloc/register_bloc.dart';
import 'package:quiero_fruta/src/bloc/user_bloc.dart';
import 'package:quiero_fruta/src/pages/choose_page.dart';
import 'package:quiero_fruta/src/pages/complete_user_page.dart';
import 'package:quiero_fruta/src/pages/confirm_order_page.dart';
import 'package:quiero_fruta/src/pages/confirm_page.dart';
import 'package:quiero_fruta/src/pages/home_page.dart';
import 'package:quiero_fruta/src/pages/login_page.dart';
import 'package:quiero_fruta/src/pages/order_page.dart';
import 'package:quiero_fruta/src/pages/register_page.dart';
import 'package:quiero_fruta/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/img/fondo.png'), context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterBloc>(create: (_) => RegisterBloc()),
        ChangeNotifierProvider<ProductBloc>(create: (_) => ProductBloc()),
        ChangeNotifierProvider<LoginBloc>(create: (_) => LoginBloc()),
        ChangeNotifierProvider(create: (_) => OrderBloc()),
        ChangeNotifierProvider(create: (_) => UserBloc()),
      ],
      child: MaterialApp(
        title: 'QuieroFruta',
        theme: ThemeData(primarySwatch: green),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (_) => HomePage(),
          '/register': (_) => RegisterPage(),
          '/confirmation': (_) => ConfirmationPage(),
          '/login': (_) => LoginPage(),
          '/order': (_) => OrderPage(),
          '/complete-user': (_) => CompleteUserPage(),
          '/confirm-order': (_) => ConfirmOrderPage(),
          '/choose': (_) => ChoosePage()
        },
      ),
    );
  }
}
