import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgrating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgrating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  // Container(
                  //   width: 235,
                  //   padding: const EdgeInsets.only(left: 10, top: 5),
                  //   child: Text(
                  //     product.name,
                  //     style: const TextStyle(fontSize: 16),
                  //     maxLines: 2,
                  //   ),
                  // ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: avgrating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Rs ${product.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'Eligible for free shipping',
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
