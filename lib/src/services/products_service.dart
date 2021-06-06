import 'dart:convert';
import '../models/Product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Datum>> getProducts() async {
    final url = Uri.https(
        'quierofrutademo.sistema.com.py', '/api_integra/app_productos.php');
    final response = await http
        .post(url, body: {"usuario": "qf_demo", "clave": "qf_demo_key"});
    final Map<String, dynamic> data = jsonDecode(response.body);
    final products = Product.fromJson(data);
    return products.data;
  }
}
