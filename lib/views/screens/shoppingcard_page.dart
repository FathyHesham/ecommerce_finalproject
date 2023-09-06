import 'package:ecommerce_finalproject/providers/provider_card.dart';
import 'package:ecommerce_finalproject/views/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCard extends StatelessWidget {
  const ShoppingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProviderCard>(
          builder: (BuildContext context, providerCard, Widget? child) {
            return Column(
              children: [
                Stack(
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
                            width: 80,
                          ),
                          const SizedBox(
                            width: 180.0,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: Colors.white,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Shopping ",
                                  ),
                                  Text(
                                    "Card",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ((providerCard.orderItem == null) ||
                            (providerCard.orderItem?.isEmpty ?? false))
                        ? const Center(
                            child: Text("No Items In Your Cart"),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: providerCard.orderItem!
                                .map((e) => CardWidget(orderItem: e))
                                .toList(),
                          )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${Provider.of<ProviderCard>(context).getTotalNumberOfItems()} item",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "\$ ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 254, 208, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                "${Provider.of<ProviderCard>(context).getTotalSalaryOfItems()}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15),
                        child: ElevatedButton(
                          onPressed: ((providerCard.orderItem == null) ||
                                  (providerCard.orderItem?.isEmpty ?? false))
                              ? null
                              : () => providerCard.buyNow(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffffe4c4),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fixedSize: const Size(double.maxFinite, 45)),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
