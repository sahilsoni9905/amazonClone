import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screen/product_screen_details.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Route<dynamic> genrateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(
                product: product,
              ));

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("screen does not exist"),
                ),
              ));
  }
}
