// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.status,
    this.data,
  });

  int status;
  List<Datum> data;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {this.idproducto,
      this.idtipoproducto,
      this.producto,
      this.idcategoria,
      this.categoria,
      this.idsubcategoria,
      this.subcategoria,
      this.precioVenta,
      this.actualizado,
      this.combo,
      this.combinado,
      this.agregados,
      this.sacados,
      this.imgProdApp});

  String idproducto;
  String idtipoproducto;
  String producto;
  String idcategoria;
  Categoria categoria;
  String idsubcategoria;
  String subcategoria;
  int precioVenta;
  DateTime actualizado;
  List<Combo> combo;
  dynamic combinado;
  List<Agregado> agregados;
  List<Sacado> sacados;
  String imgProdApp;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      idproducto: json["idproducto"],
      idtipoproducto: json["idtipoproducto"],
      producto: json["producto"],
      idcategoria: json["idcategoria"],
      categoria: categoriaValues.map[json["categoria"]],
      idsubcategoria: json["idsubcategoria"],
      subcategoria: json["subcategoria"],
      precioVenta: json["precio_venta"],
      actualizado: DateTime.parse(json["actualizado"]),
      combo: List<Combo>.from(json["combo"].map((x) => Combo.fromJson(x))),
      combinado: json["combinado"],
      agregados: List<Agregado>.from(
          json["agregados"].map((x) => Agregado.fromJson(x))),
      sacados:
          List<Sacado>.from(json["sacados"].map((x) => Sacado.fromJson(x))),
      imgProdApp: json["img_prod_app"]);

  Map<String, dynamic> toJson() => {
        "idproducto": idproducto,
        "idtipoproducto": idtipoproducto,
        "producto": producto,
        "idcategoria": idcategoria,
        "categoria": categoriaValues.reverse[categoria],
        "idsubcategoria": idsubcategoria,
        "subcategoria": subcategoria,
        "precio_venta": precioVenta,
        "actualizado": actualizado.toIso8601String(),
        "combo": List<dynamic>.from(combo.map((x) => x.toJson())),
        "combinado": combinado,
        "agregados": List<dynamic>.from(agregados.map((x) => x.toJson())),
        "sacados": List<dynamic>.from(sacados.map((x) => x.toJson())),
      };
}

class Agregado {
  Agregado({
    this.idproductoIng,
    this.precioAdicional,
  });

  String idproductoIng;
  String precioAdicional;

  factory Agregado.fromJson(Map<String, dynamic> json) => Agregado(
        idproductoIng: json["idproducto_ing"],
        precioAdicional: json["precio_adicional"],
      );

  Map<String, dynamic> toJson() => {
        "idproducto_ing": idproductoIng,
        "precio_adicional": precioAdicional,
      };
}

enum Categoria {
  A_AI,
  HELADOS_Y_PALETAS,
  ENSALADA_DE_FRUTAS,
  JUGOS,
  ALMACEN,
  MBUJAPE,
  ADICIONALES,
  TAPIOCA,
  WAFLES,
  FRUTAS_CON_CHANTILLY,
  FRUTERIA_BOUTIQUE,
  SANDWICHES_QF,
  CAFETERIA,
  COMBOS_QF,
  DELIVERY,
  FRUTAS_EN_VASOS,
  OMELETTE,
  HUEVOS_REVUELTOS
}

final categoriaValues = EnumValues({
  "ADICIONALES": Categoria.ADICIONALES,
  "ALMACEN": Categoria.ALMACEN,
  "AÃ\u0087AI": Categoria.A_AI,
  "CAFETERIA": Categoria.CAFETERIA,
  "COMBOS QF": Categoria.COMBOS_QF,
  "DELIVERY": Categoria.DELIVERY,
  "ENSALADA DE FRUTAS": Categoria.ENSALADA_DE_FRUTAS,
  "FRUTAS CON CHANTILLY": Categoria.FRUTAS_CON_CHANTILLY,
  "FRUTAS EN VASOS": Categoria.FRUTAS_EN_VASOS,
  "FRUTERIA BOUTIQUE": Categoria.FRUTERIA_BOUTIQUE,
  "HELADOS Y PALETAS": Categoria.HELADOS_Y_PALETAS,
  "HUEVOS REVUELTOS": Categoria.HUEVOS_REVUELTOS,
  "JUGOS": Categoria.JUGOS,
  "MBUJAPE": Categoria.MBUJAPE,
  "OMELETTE": Categoria.OMELETTE,
  "SANDWICHES QF": Categoria.SANDWICHES_QF,
  "TAPIOCA": Categoria.TAPIOCA,
  "WAFLES": Categoria.WAFLES
});

class CombinadoClass {
  CombinadoClass({
    this.productosPermitidos,
    this.minimoItems,
    this.maximoItems,
    this.tipoPrecio,
  });

  String productosPermitidos;
  String minimoItems;
  String maximoItems;
  String tipoPrecio;

  factory CombinadoClass.fromJson(Map<String, dynamic> json) => CombinadoClass(
        productosPermitidos: json["productos_permitidos"],
        minimoItems: json["minimo_items"],
        maximoItems: json["maximo_items"],
        tipoPrecio: json["tipo_precio"],
      );

  Map<String, dynamic> toJson() => {
        "productos_permitidos": productosPermitidos,
        "minimo_items": minimoItems,
        "maximo_items": maximoItems,
        "tipo_precio": tipoPrecio,
      };
}

class Combo {
  Combo({
    this.idlistacombo,
    this.nombre,
    this.cantidad,
    this.productosPermitidos,
  });

  String idlistacombo;
  String nombre;
  String cantidad;
  String productosPermitidos;

  factory Combo.fromJson(Map<String, dynamic> json) => Combo(
        idlistacombo: json["idlistacombo"],
        nombre: json["nombre"],
        cantidad: json["cantidad"],
        productosPermitidos: json["productos_permitidos"],
      );

  Map<String, dynamic> toJson() => {
        "idlistacombo": idlistacombo,
        "nombre": nombre,
        "cantidad": cantidad,
        "productos_permitidos": productosPermitidos,
      };
}

class Sacado {
  Sacado({
    this.idinsumo,
    this.insumoDesc,
  });

  String idinsumo;
  String insumoDesc;

  factory Sacado.fromJson(Map<String, dynamic> json) => Sacado(
        idinsumo: json["idinsumo"],
        insumoDesc: json["insumo_desc"],
      );

  Map<String, dynamic> toJson() => {
        "idinsumo": idinsumo,
        "insumo_desc": insumoDesc,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
