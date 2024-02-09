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
      {required context, required String category}) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      print("part 1 phuch gye");
      http.Response res = await http.get(
        // very important
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
      );
      print("part 2 phuch gye");
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      print("yha p error aa rha kuch part 1");
      showSnackbar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfTheDay({required context}) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);
    try {
      print('sahil1');
      http.Response res = await http.get(
        // very important
        Uri.parse('$uri/api/deal-of-the-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
      );
      print("sahil2");
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      print("yah p kuch error h part2");
      showSnackbar(context, e.toString());
    }
    return product;
  }
}
