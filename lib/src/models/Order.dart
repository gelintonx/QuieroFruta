// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.codigoExterno,
    this.llevapos,
    this.idsucursal,
    this.idcliente,
    this.idcanal,
    this.nombreCarry,
    this.telefono,
    this.montoPedido,
    this.cambio,
    this.observacion,
    this.detalle,
  });

  int codigoExterno;
  String llevapos;
  int idsucursal;
  int idcliente;
  String idcanal;
  String nombreCarry;
  String telefono;
  int montoPedido;
  int cambio;
  String observacion;
  Map<dynamic, Detalle> detalle;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        codigoExterno: json["codigo_externo"],
        llevapos: json["llevapos"],
        idsucursal: json["idsucursal"],
        idcliente: json["idcliente"],
        idcanal: json["idcanal"],
        nombreCarry: json["nombre_carry"],
        telefono: json["telefono"],
        montoPedido: json["monto_pedido"],
        cambio: json["cambio"],
        observacion: json["observacion"],
        detalle: Map.from(json["detalle"]).map((k, v) =>
            MapEntry<String, Detalle>(k.toString(), Detalle.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "codigo_externo": codigoExterno,
        "llevapos": llevapos,
        "idsucursal": idsucursal,
        "idcliente": idcliente,
        "idcanal": idcanal,
        "nombre_carry": nombreCarry,
        "telefono": telefono,
        "monto_pedido": montoPedido,
        "cambio": cambio,
        "observacion": observacion,
        "detalle": Map.from(detalle)
            .map((k, v) => MapEntry<String, dynamic>(k.toString(), v.toJson())),
      };
}

class Detalle {
  Detalle({this.idproducto, this.cantidad, this.observacion});

  String idproducto;
  int cantidad;
  String observacion;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
      idproducto: json["idproducto"],
      cantidad: json["cantidad"],
      observacion: json["observacion"]);

  Map<String, dynamic> toJson() => {
        "idproducto": idproducto,
        "cantidad": cantidad,
        "observacion": observacion,
      };
}
