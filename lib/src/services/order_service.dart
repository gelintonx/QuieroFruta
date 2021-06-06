import 'dart:convert';
import 'package:dio/dio.dart';

class OrderService {
  final dio = Dio();

  createOrder(order) async {
    final postData = FormData.fromMap(<String, dynamic>{
      "usuario": "qf_demo",
      "clave": "qf_demo_key",
      "pedido": order
    });

    try {
      final response = await dio.post(
        'https://quierofrutademo.sistema.com.py/api_integra/app_pedidos.php',
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
        ),
        data: postData,
      );
      final data = jsonDecode(response.data);
      print(data);
      return {"status": data['status'], "error": data['data']['errores']};
    } catch (e) {
      return e;
    }
  }
}
