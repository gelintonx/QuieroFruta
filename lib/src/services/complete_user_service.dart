import 'dart:convert';
import 'package:quiero_fruta/src/models/User.dart';
import 'package:dio/dio.dart';

class UserService {
  final dio = Dio();
  createUser(User user) async {
    final client = json.encode({
      "accion": "a",
      "canal": "c",
      "nombres": user.nombres,
      "apellidos": user.apellidos,
      "telefono": user.telefono,
      "ruc": user.ruc,
      "razon_social": user.ruc,
      "tipocliente": "1"
    });
    final postData = FormData.fromMap(<String, dynamic>{
      "usuario": "qf_demo",
      "clave": "qf_demo_key",
      "cliente": client
    });

    try {
      final response = await dio.post(
        'https://quierofrutademo.sistema.com.py/api_integra/app_cliente.php',
        options: Options(contentType: 'application/x-www-form-urlencoded'),
        data: postData,
      );
      final data = jsonDecode(response.data);
      return data['data']['idcliente']
          ? data['data']['idcliente']
          : data['data'];
    } catch (e) {
      return e;
    }
  }
}
