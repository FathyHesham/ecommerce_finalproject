import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:ecommerce_finalproject/providers/provider_favourite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({required this.product, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffe4c4),
                  ),
                  height: 400,
                  child: Center(
                    child: CachedNetworkImage(
                      height: 230,
                      width: 260,
                      imageUrl: widget.product.image ?? "",
                      placeholder: (context, url) => const SizedBox(
                          height: 15,
                          width: 15,
                          child: FittedBox(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 350,
                  child: Container(
                    height: 70,
                    width: 410,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 60,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: InkWell(
                      onTap: () => onFavouriteClicked(context),
                      child: Provider.of<ProviderFavourite>(
                        context,
                      ).isFavourite(widget.product.id ?? 0)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                              size: 30,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title ?? "No Title",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Text(
                        "\$ ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 254, 208, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.product.price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ...List.generate(
                    5,
                    (index) {
                      if ((widget.product.rating!.rate! - (index + 1)) >= 0) {
                        return const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        );
                      } else {
                        if ((widget.product.rating!.rate! - (index + 1)) < -1) {
                          return const Icon(
                            Icons.star,
                            color: Colors.grey,
                          );
                        } else {
                          if ((widget.product.rating!.rate! - (index + 1)) <
                              0.5) {
                            return const Icon(
                              Icons.star,
                              color: Colors.grey,
                            );
                          } else {
                            return const Icon(
                              Icons.star_half_sharp,
                              color: Colors.yellow,
                            );
                          }
                        }
                      }
                    },
                  ),
                  Text('(${widget.product.rating?.count})')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffe4c4),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(totalRepeatCount: 10, animatedTexts: [
                        TypewriterAnimatedText(
                          "Description",
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
              child: Text(
                widget.product.description ?? "No Description",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 70, left: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffffe4c4),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Add To Card",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // create func. to clich on the bottom favourite products
  void onFavouriteClicked(BuildContext context) {
    // Check if the product is in the list of various options on its identity (id)
    if (Provider.of<ProviderFavourite>(context, listen: false)
        .isFavourite(widget.product.id ?? 0)) {
      // If the product is in Favorites, remove it from the Favorites list
      Provider.of<ProviderFavourite>(context, listen: false)
          .removeFavouriteProducts(widget.product.id ?? 0);
      return;
    }
    // If the product is not in your favorites, add it to your favorites list
    Provider.of<ProviderFavourite>(context, listen: false)
        .addFavouriteProducts(widget.product);
  }
}
