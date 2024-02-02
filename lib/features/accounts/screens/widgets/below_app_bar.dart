import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            "Hello,  ",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          Text(
            user.name,
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
