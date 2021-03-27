import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum Filters { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop App"),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (Filters selectedValue) {
                  setState(() {
                    if (selectedValue == Filters.Favorites)
                      _showOnlyFavorites = true;
                    else
                      _showOnlyFavorites = false;
                  });
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text("Favorites"), value: Filters.Favorites),
                      PopupMenuItem(
                          child: Text("Show All"), value: Filters.All),
                    ]),
            Consumer<Cart>(
              builder: (_, cart, child) => Badge(
                child: child,
                value: cart.itemCount.toString(),
              ),
              child:
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            )
          ],
        ),
        body: ProductsGrid(_showOnlyFavorites));
  }
}
