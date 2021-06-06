import '../bloc/order_bloc.dart';
import '../bloc/products_bloc.dart';
import '../utils/colors.dart';
import '../utils/icon_color.dart';
import '../utils/navigate.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiero_fruta/src/utils/configureAmplify.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage> {
  bool isCharged = false;
  bool visible = true;

  @override
  void initState() {
    super.initState();
    configureAmplify();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1));
      context.read<ProductBloc>().init(this);
      isCharged = true;
      /*final categories = context.read<ProductBloc>().categories;
      if (categories != []) {
        context.read<ProductBloc>().reset();
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final productProvider = Provider.of<ProductBloc>(context);

    return isCharged
        ? Stack(children: [
            Positioned.fill(
                child: Image(
                    image: AssetImage('assets/img/fondo1.png'),
                    fit: BoxFit.fill)),
            WillPopScope(
              onWillPop: () => null,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    iconTheme: iconColor,
                    elevation: 0.0,
                    backgroundColor: Color(0xFFF16B24),
                  ),
                  drawer: ArasaDrawer(),
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '🔎 Busque el producto que desea',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent))),
                              onTap: () {
                                showSearch(
                                    context: context, delegate: DataSearch());
                              }),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              height: 55,
                              color: Colors.white,
                              child: TabBar(
                                  key: UniqueKey(),
                                  controller: productProvider.tabController,
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          width: 3.5,
                                          color: Color(0xFFF78C1A))),
                                  onTap: productProvider.onCategorySelected,
                                  isScrollable: true,
                                  tabs: productProvider.categoryWidget),
                            )),
                        Expanded(
                            child: Container(
                                clipBehavior: Clip.none,
                                child: ListView.builder(
                                  controller: productProvider.scrollController,
                                  itemCount: productProvider.products.length,
                                  itemBuilder: (context, i) {
                                    final product = productProvider.products[i];
                                    return ProductCard(
                                      productId: product['id'],
                                      name: product['name'],
                                      img: product['img'],
                                      price: product['price'],
                                    );
                                  },
                                ))),
                        Container(
                          height: 100,
                          child: Consumer<OrderBloc>(
                            builder: (_, order, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Productos: ${order.productsCard.length}'),
                                  Text('Total: ${order.totalPrice.toString()}'),
                                  IconButton(
                                      icon: Icon(Icons.arrow_right,
                                          size: 40, color: green),
                                      onPressed: () {
                                        if (order.productsCard.length > 0) {
                                          navigate(context, '/order');
                                        } else {
                                          final snackbar = SnackBar(
                                            content: Text(
                                                'Debe seleccionar almenos un producto antes de crear un pedido'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => order.deleteCart())
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ])
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  bool get wantKeepAlive => true;
}

class DataSearch extends SearchDelegate<String> {
  /*final products = [
    {"name": "Camadiña 300 ml", "price": 14000},
    {"name": "Camadiña 400 ml", "price": 18000},
    {"name": "camadiña 700 ml", "price": 28000},
    {"name": "1 bocha americana+vaso 200", "price": 5000},
    {"name": "frozen acai 300 ml", "price": 15000}
  ];*/

  final products = ["Camadiña"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            close(context, '');
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listSuggestions = (query.isEmpty)
        ? products
        : products
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: listSuggestions.length,
        itemBuilder: (_, int i) {
          final suggestion = listSuggestions[i];
          return ProductCard(
            name: suggestion,
            price: 200,
          );
        });
  }

  @override
  void close(BuildContext context, result) {
    Navigator.pop(context);
  }
}
