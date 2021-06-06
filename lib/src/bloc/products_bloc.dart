import 'package:flutter/material.dart';
import '../services/products_service.dart';
import '../widgets/category_tab_widget.dart';
import 'dart:convert' show utf8, latin1;

const productHeight = 120.0;
const categoryHeight = 55.0;

class ProductBloc extends ChangeNotifier {
  List<Map<String, dynamic>> _products = [];
  List<String> _categories = [];
  List<CategoryTab> _categoryWidget = [];

  TabController tabController;
  ScrollController scrollController = ScrollController();

  void init(TickerProvider tickerProvider) async {
    final service = ProductService();
    final response = await service.getProducts();

    double offsetForm = 0.0;

    for (int i = 0; i < response.length; i++) {
      final category = response[i];
      if (_categories.contains(category.categoria.toString())) {
      } else {
        _categories.add(category.categoria.toString());
      }
    }

    for (int i = 0; i < _categories.length; i++) {
      final category = _categories[i];
      if (i > 0) {
        offsetForm += _categories[i - 1].length * productHeight;
      }
      _categoryWidget.add(CategoryTab(
          category: category,
          selected: (i == 0),
          offsetForm: categoryHeight * i + offsetForm));
    }

    for (var j in response) {
      var x = latin1.encode(j.producto);
      var y = utf8.decode(x);
      _products.add({
        "id": j.idproducto,
        "name": y,
        "price": j.precioVenta,
        "category": j.categoria.toString(),
        "img": j.imgProdApp,
        "add": j.agregados
      });
    }

    tabController =
        TabController(length: _categoryWidget.length, vsync: tickerProvider);

    notifyListeners();
  }

  void reset() {
    _products.clear();
    _categories.clear();
    _categoryWidget.clear();
    notifyListeners();
  }

  void onCategorySelected(int index) {
    final selected = _categoryWidget[index];
    for (int i = 0; i < _categoryWidget.length; i++) {
      final condition = selected.category == _categoryWidget[i].category;
      _categoryWidget[i] = _categoryWidget[i].copyWith(condition);
    }
    notifyListeners();
    scrollController.animateTo(selected.offsetForm,
        duration: const Duration(milliseconds: 500), curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  get categories => _categories;
  get products => _products;
  get categoryWidget => _categoryWidget;
}

class Item {
  final String category;
  final List<Map<String, dynamic>> products;

  const Item({this.category, this.products});

  bool get isCategory => category != null;
}
