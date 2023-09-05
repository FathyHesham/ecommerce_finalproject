import 'package:ecommerce_finalproject/providers/provider_favourite.dart';
import 'package:ecommerce_finalproject/providers/provider_products.dart';
import 'package:ecommerce_finalproject/services/prefservice.dart';
import 'package:ecommerce_finalproject/views/screens/electronics_page.dart';
import 'package:ecommerce_finalproject/views/screens/favourite_page.dart';
import 'package:ecommerce_finalproject/views/screens/home_page.dart';
import 'package:ecommerce_finalproject/views/screens/jewelery_page.dart';
import 'package:ecommerce_finalproject/views/screens/menclothing_page.dart';
import 'package:ecommerce_finalproject/views/screens/welcom_page.dart';
import 'package:ecommerce_finalproject/views/screens/womanclothing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderProduct()),
        ChangeNotifierProvider(create: (_) => ProviderFavourite()),
      ],
      child: const ECommerce(),
    ),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ECommerce extends StatefulWidget {
  const ECommerce({super.key});

  @override
  State<ECommerce> createState() => _ECommerceState();
}

class _ECommerceState extends State<ECommerce> with TickerProviderStateMixin {  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const WelcomPage(),
      routes: {
        "/homepage": (_) => const HomePage(),
        "/electronics": (_) => const ElectronicsPage(),
        "/jewelery": (_) => const Jewelery(),
        "/menclothing": (_) => const MenClothing(),
        "/womanclothing": (_) => const WomanClothing(),
        "/favouritepage": (_) => const FavouritePage(),
      },
    );
  }
}
