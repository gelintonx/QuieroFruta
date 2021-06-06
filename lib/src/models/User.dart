// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.nombres,
    this.apellidos,
    this.telefono,
    this.ruc,
  });

  String nombres;
  String apellidos;
  String telefono;
  String ruc;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        ruc: json["ruc"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "ruc": ruc,
      };
}
