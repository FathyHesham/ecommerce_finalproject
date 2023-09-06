import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_finalproject/models/orderitem_model.dart';
import 'package:ecommerce_finalproject/providers/provider_card.dart';
import 'package:ecommerce_finalproject/views/screens/poductsdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final OrderItem orderItem;
  const CardWidget({required this.orderItem, super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  //! create func. when the interface is initialized
  //! and used to initialize the initial data
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderCard>(context, listen: false)
          .getItemsQuantity(widget.orderItem.product?.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCard>(
      builder: (context, providerCard, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProductDetailsPage(
                        product: widget.orderItem.product!))),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffe4c4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 130,
                      height: 100,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.orderItem.product?.image ?? "",
                        placeholder: (context, url) => const SizedBox(
                          height: 15,
                          width: 15,
                          child: FittedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            widget.orderItem.product?.title ?? "No Title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$ ${widget.orderItem.price.toString()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    providerCard.removeItemFromCard(
                                        widget.orderItem.product?.id ?? 0),
                                icon: const Icon(
                                  Icons.delete_sharp,
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                            onPressed: () =>
                                                providerCard.changeItemQuantity(
                                                    widget.orderItem.product
                                                            ?.id ??
                                                        0,
                                                    decrease: true),
                                            icon: const Icon(
                                              Icons.remove_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.orderItem.quantity
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                              onPressed: () => providerCard
                                                  .changeItemQuantity(
                                                      widget.orderItem.product
                                                              ?.id ??
                                                          0,
                                                      decrease: false),
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
