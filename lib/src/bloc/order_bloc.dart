import 'dart:convert';

import 'package:quiero_fruta/src/bloc/user_bloc.dart';
import 'package:quiero_fruta/src/device/save_user.dart';
import 'package:quiero_fruta/src/models/Order.dart';
import 'package:quiero_fruta/src/services/order_service.dart';
import '../utils/get_code.dart';
import 'package:flutter/material.dart';

class OrderBloc extends ChangeNotifier {
  List<Map<String, dynamic>> productsCard = [];
  List<Detalle> products = [];
  int totalPrice = 0;

  addToCart(String productId, String product, int price, String img,
      int quantity, List add) {
    
        var condition = productsCard.where((element) => element['name'] == product);

        if(condition.isEmpty) {
          productsCard
        .add({"id": productId, "name": product, "img": img, "add": add});

        products
        .add(Detalle(idproducto: productId, cantidad: 1, observacion: 'test'));

        totalPrice += price;

        } else {
          return false;
        }
        
        
        notifyListeners();
        return true;
    
    
  
  }
   
  

  void deleteCart() {
    totalPrice = 0;
    productsCard.clear();
    products.clear();
    notifyListeners();
  }

  addQuantity(id) {
    for (var x in products) {
      if (x.idproducto == id) {
        x.cantidad += 1;
        return x.cantidad;
      }
    }
    notifyListeners();
  }

  confirmOrder(id) async {
    final code = getCode();
    final user = SaveUser();
    final phone = await UserBloc().phoneNumber;
    final name = await user.getName();
    final costumerId = await user.getCostumerId();

    final order = Order(
        codigoExterno: code,
        llevapos: "S",
        idsucursal: 1,
        idcliente: 914, //int.parse(costumerId),
        idcanal: id,
        nombreCarry: name,
        telefono: phone,
        montoPedido: totalPrice,
        cambio: 0,
        observacion: '',
        detalle: products.asMap());

    final orderJson = json.encode(order);
    final orderService = OrderService();
    final response = await orderService.createOrder(orderJson);
    return response;
  }
}
