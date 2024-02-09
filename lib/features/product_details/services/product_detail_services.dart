import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
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
