import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:ecommerce_finalproject/providers/provider_products.dart';
import 'package:ecommerce_finalproject/views/widgets/createproduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MenClothing extends StatefulWidget {
  const MenClothing({super.key});

  @override
  State<MenClothing> createState() => _MenClothingState();
}

class _MenClothingState extends State<MenClothing> {
  @override
  void initState() {
    Provider.of<ProviderProduct>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                          width: 59,
                        ),
                        SizedBox(
                          width: 150.0,
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
                                FlickerAnimatedText('Men Clothing'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/favouritepage");
                          },
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                          iconSize: 30,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: getProductsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProductsWidget() {
    if (Provider.of<ProviderProduct>(context).products?.isEmpty ?? false) {
      return const Text('No Products Found');
    } else {
      return Skeletonizer(
        enabled: Provider.of<ProviderProduct>(context).products == null
            ? true
            : false,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: .7,
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: Provider.of<ProviderProduct>(context)
                  .products
                  ?.map((e) => ProductWidget(product: e))
                  .toList() ??
              List.generate(6, (index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: ProductWidget(
                        product: Product(),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }
}
