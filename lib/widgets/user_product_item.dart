import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                arguments: id
                );
              },
              color: Theme.of(context).accentColor),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              try{
              await Provider.of<Products>(context, listen: false).deleteProduct(id);
              }catch(error){
                scaffold.showSnackBar(
                    SnackBar(
                        content:
                        Text(
                            'Deleting failed')
                    ),
                );
              }
            },
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
