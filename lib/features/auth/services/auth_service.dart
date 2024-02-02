import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          email: email,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print("the res is $res");

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context,
                'Account has been successfully created !!  now login with the same credentials');
          });
      // ignore: avoid_print
      print('account successfully created');
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print("oure res.body is : " + res.body);
      print("oure resis : " + res.toString());

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackbar(context, 'login successfull');

            SharedPreferences prefs = await SharedPreferences.getInstance();

            Provider.of<userProvider>(context, listen: false).setUser(res.body);

            //now under a x-auth-token key token is stored that was saved by server
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      print("there is something error");
      showSnackbar(context, e.toString());
    }
  }
  //get user data

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var UserProvider = Provider.of<userProvider>(context, listen: false);
        UserProvider.setUser(userRes.body);
      }
    } catch (e) {
      print("there is something error");
      showSnackbar(context, e.toString());
    }
  }
}
