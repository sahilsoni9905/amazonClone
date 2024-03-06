import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseno = TextEditingController();
  final TextEditingController localitycontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  @override
  void disposse() {
    super.dispose();
    houseno.dispose();
    localitycontroller.dispose();
    pincodecontroller.dispose();
  }

  void gpayresult() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        padding: const EdgeInsets.all(8),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Form(
          key: _addressFormKey,
          child: Column(
            children: [
              CustomTextField(
                controller: houseno,
                hintText: "house no.",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: localitycontroller,
                hintText: "locality",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: pincodecontroller,
                hintText: "pincode ",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(text: 'Pay !!', ontap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
