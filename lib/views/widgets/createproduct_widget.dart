import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:ecommerce_finalproject/providers/provider_favourite.dart';
import 'package:ecommerce_finalproject/views/screens/poductsdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductDetailsPage(product: product))),
      child: Container(
          height: 220,
          width: 170,
          decoration: BoxDecoration(
              color: const Color(0xffffe4c4),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'sale',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () => onFavouriteClicked(context),
                      child: Provider.of<ProviderFavourite>(
                        context,
                      ).isFavourite(product.id ?? 0)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                            ))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: product.image ?? '',
                    placeholder: (context, url) => const SizedBox(
                        height: 15,
                        width: 15,
                        child: FittedBox(
                          child: CircularProgressIndicator(),
                        )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    product.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black.withOpacity(.9)),
                  )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Price : ${product.price}\$',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black.withOpacity(.75)),
                  )),
                ],
              ),
            ]),
          )),
    );
  }

// create func. to clich on the bottom favourite products
  void onFavouriteClicked(BuildContext context) {
    // Check if the product is in the list of various options on its identity (id)
    if (Provider.of<ProviderFavourite>(context, listen: false)
        .isFavourite(product.id ?? 0)) {
      // If the product is in Favorites, remove it from the Favorites list
      Provider.of<ProviderFavourite>(context, listen: false)
          .removeFavouriteProducts(product.id ?? 0);
      return;
    }
    // If the product is not in your favorites, add it to your favorites list
    Provider.of<ProviderFavourite>(context, listen: false)
        .addFavouriteProducts(product);
  }
}
