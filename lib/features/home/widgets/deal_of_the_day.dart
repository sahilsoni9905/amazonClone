import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final Homeservices homeservices = Homeservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeservices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      "Deal Of The Day!!",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  Image.network(
                    'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y29tcHV0ZXJ8ZW58MHx8MHx8fDA%3D',
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Rs 99,999",
                      style: TextStyle(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                    child: Text(
                      "sahil macbook",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          "https://images.unsplash.com/photo-1496065187959-7f07b8353c55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1496065187959-7f07b8353c55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1496065187959-7f07b8353c55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                        Image.network(
                          "https://images.unsplash.com/photo-1496065187959-7f07b8353c55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D",
                          fit: BoxFit.fitWidth,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "see all deals",
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}
