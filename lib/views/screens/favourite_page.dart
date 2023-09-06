import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_finalproject/providers/provider_favourite.dart';
import 'package:ecommerce_finalproject/views/widgets/createproduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: const BoxDecoration(
                    color: Color(0xffffe4c4),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    const SizedBox(
                      width: 105,
                    ),
                    SizedBox(
                      width: 130.0,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              blurRadius: 7.0,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FlickerAnimatedText('Fvourites'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/shoppingcard");
                      },
                      icon: const Icon(Icons.shopping_cart),
                      color: Colors.black,
                      iconSize: 30,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (Provider.of<ProviderFavourite>(context)
                                .productsFavourite ==
                            null ||
                        (Provider.of<ProviderFavourite>(context)
                                .productsFavourite
                                ?.isEmpty ??
                            false))
                    ? const Center(
                        child: Text('No Favourite Products'),
                      )
                    : GridView.count(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: Provider.of<ProviderFavourite>(context)
                                .productsFavourite
                                ?.map((e) => ProductWidget(product: e))
                                .toList() ??
                            [],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
