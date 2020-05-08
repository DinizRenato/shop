import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/cart.dart';

import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Product product = Provider.of<Product>(context, listen: false);
    
    //LISTEN = FALSE PQ NESSE WIDGET AS NOTIFICAÇÕES DO PROVIDER 
    //NÃO CAUSARÃO NENHUM IMPACTO NECESSÁRIO ATUALIZAÇÃO
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: product
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            // Consumer envolvendo o único parametro 
            // da classe que pode haver mudança
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavorite();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(product);
              },
            ),
          ),
        ),
      );
  }
}
