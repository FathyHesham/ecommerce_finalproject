import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_finalproject/providers/provider_favourite.dart';
import 'package:ecommerce_finalproject/providers/provider_products.dart';
import 'package:ecommerce_finalproject/views/widgets/advertisement_widget.dart';
import 'package:ecommerce_finalproject/views/widgets/createcategory_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ProviderFavourite>(context, listen: false)
        .getFavouriteProducts();
    Provider.of<ProviderProduct>(context, listen: false).getCategories();
    Provider.of<ProviderProduct>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.red,
              height: 500.0,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "asses/images/background.jpg",
                    )),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.4),
                ])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                              icon: const Icon(Icons.shopping_cart),
                              color: const Color(0xffffe4c4),
                              iconSize: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AnimatedTextKit(
                                      totalRepeatCount: 10,
                                      animatedTexts: [
                                        WavyAnimatedText(
                                          "Our New Products",
                                          speed:
                                              const Duration(milliseconds: 300),
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                          "Advertisement",
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
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Advertisement(),
                    SizedBox(
                      width: 10,
                    ),
                    Advertisement(
                      backgroundCard: Color(0xfffbceb1),
                      buttomColor: Color(0xffcd9575),
                      buttomTextColor: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffe4c4),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(totalRepeatCount: 10, animatedTexts: [
                        TypewriterAnimatedText(
                          "Categories",
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
            const SizedBox(
              height: 10,
            ),
            categoryWidget(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryWidget() {
    if (Provider.of<ProviderProduct>(context).categories?.isEmpty ?? false) {
      return const Text('Not Found');
    } else {
      return SizedBox(
        height: 65,
        child: Skeletonizer(
          enabled: Provider.of<ProviderProduct>(context).categories == null
              ? true
              : false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: Provider.of<ProviderProduct>(context)
                          .categories
                          ?.map((e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: CreateCategory(
                                  cateName: e,
                                ),
                              ))
                          .toList() ??
                      List.generate(
                          4,
                          (index) => const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: CreateCategory(cateName: ""),
                              ))),
            ],
          ),
        ),
      );
    }
  }
}
