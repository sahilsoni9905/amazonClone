import 'dart:convert';
import 'dart:math';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    try {
      print("req bhej diya h");
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': UserProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id,
          }));
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                UserProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            UserProvider.setUserFromModel(user);
          });
    } catch (e) {
      print("yha p dikkat h part3");
      showSnackbar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': UserProvider.user.token,
          },
          body: jsonEncode({
            'id': product.id,
            'rating': rating,
          }));
      httpErrorHandler(response: res, context: context, onSuccess: () {});
    } catch (e) {
      print("yha p dikkat h part3");
      showSnackbar(context, e.toString());
    }
  }
}
