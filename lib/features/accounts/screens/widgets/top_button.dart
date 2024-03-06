import 'package:amazon_clone/features/accounts/screens/widgets/account_button.dart';
import 'package:amazon_clone/features/accounts/services/accouts_services.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Log Out',
                onTap: () => AccountServices().logOut(context)),
            AccountButton(text: 'Your Wish List', onTap: () {})
          ],
        )
      ],
    );
  }
}
