import 'package:ecommerce_finalproject/providers/provider_products.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateCategory extends StatelessWidget {
  final String cateName;
  const CreateCategory({required this.cateName, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderProduct>(builder:
        (BuildContext context, ProviderProduct productProvider, Widget? child) {
      return InkWell(
        onTap: () {
          if (cateName == "electronics") {
            productProvider.changeCategories(cateName);
            Navigator.pushNamed(context, "/electronics");
          } else if (cateName == "jewelery") {
            productProvider.changeCategories(cateName);
            Navigator.pushNamed(context, "/jewelery");
          } else if (cateName == "men\'s clothing") {
            productProvider.changeCategories(cateName);
            Navigator.pushNamed(context, "/menclothing");
          } else {
            productProvider.changeCategories(cateName);
            Navigator.pushNamed(context, "/womanclothing");
          }
        },
        child: Container(
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffffe4c4)),
              color: productProvider.selectCategories == cateName
                  ? const Color(0xffD9D9D9)
                  : const Color(0xffffe4c4).withOpacity(0.9),
              borderRadius: BorderRadius.circular(10)),
          child: Skeleton.replace(
            child: Center(
              child: Icon(
                getIcon(),
                size: 30,
                color: productProvider.selectCategories == cateName
                    ? const Color(0xffffe4c4)
                    : Colors.black.withOpacity(.5),
              ),
            ),
          ),
        ),
      );
    });
  }

  IconData getIcon() {
    switch (cateName) {
      case 'men\'s clothing':
        return LineIcons.tShirt;
      case 'women\'s clothing':
        return Icons.woman;
      case 'jewelery':
        return LineIcons.gem;
      case 'electronics':
        return LineIcons.laptop;

      default:
        return Icons.no_backpack;
    }
  }
}
