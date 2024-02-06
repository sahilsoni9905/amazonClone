import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:provider/provider.dart';

class Homeservices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext, required String category}) async {
    final UserProvider = Provider.of<userProvider>(BuildContext, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        // very important
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
      );
      httpErrorHandler(
          response: res,
          context: BuildContext,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackbar(BuildContext, e.toString());
    }
    return productList;
  }
}
