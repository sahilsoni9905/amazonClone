import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart ' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProducts(
      {required context, required String searchQuery}) async {
    final UserProvider = Provider.of<userProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      print("part 1 phuch gye");
      http.Response res = await http.get(
        // very important
        Uri.parse('$uri/api/products/search/$searchQuery'),
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
      print("yha p part 4 me dikkat h");
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
