import 'package:quiero_fruta/src/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String productId;
  final String name;
  final int price;
  final String img;
  final List add;

  ProductCard({this.productId, this.name, this.price, this.img, this.add});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    final provider = Provider.of<OrderBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Card(
          elevation: 6,
          child: ListTile(
            isThreeLine: true,
            title: Text('${widget.name.toUpperCase()}'),
            subtitle: widget.price == null
                ? Text('Cantidad: ${quantity.toString()}')
                : Text('Precio: ${widget.price}'),
            leading: widget.img != ''
                ? Image.network(widget.img, height: 150)
                : Image.asset('assets/img/placeholder.png'),
            trailing: widget.price == null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            final response =
                                provider.addQuantity(widget.productId);
                            print(response);
                            setState(() {
                              quantity = response;
                            });
                            print(quantity);
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: IconButton(
                        icon: Icon(Icons.add, color: Colors.black),
                        onPressed: () {
                          final response =  provider.addToCart(widget.productId, widget.name,
                              widget.price, widget.img, quantity, widget.add);
                          if(response == false) {
                             final snackbar = SnackBar(
                                            content: Text(
                                                'Este producto ya se encuentra en la cesta si quiere añadir más cantidad dirijase al carrito'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                          }
                        })),
          ),
        ),
      ),
    );
  }
}
