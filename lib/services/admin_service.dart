import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dnnge30kx', 'oqq3dwi0');
      List<String> imagesUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrls.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imagesUrls,
          category: category,
          price: price);
      print("going to give to server");

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
        body: product.toJson(),
      );
      print("received output from server");
      print(res.body);
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Product Added Successfully');
          });
    } catch (e) {
      showSnackbar(context, "yha error h" + e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
      );
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
      showSnackbar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': UserProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
