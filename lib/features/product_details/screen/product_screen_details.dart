import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/model/product.models.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  static const String routeName = '/product-details';
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating = totalRating + widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<userProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselImagesWidgets = [];
    List<String> carouselImages = widget.product.images;

    if (carouselImages != null) {
      for (int i = 0; i < carouselImages.length; i++) {
        carouselImagesWidgets.add(
          Builder(
            builder: (BuildContext context) => Image.network(
              carouselImages[i],
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
        );
      }
    } else {
      // You might want to handle the case when carouselImages is null
      // You can add a placeholder image or display an error message
      carouselImagesWidgets.add(
        Text('No images available'),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  Stars(rating: avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 16),
              ),
            ),
            CarouselSlider(
              items: carouselImagesWidgets,
              options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Color.fromARGB(154, 174, 174, 174),
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CustomButton(
                text: 'Buy Now',
                ontap: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CustomButton(
                text: 'Add To Cart',
                ontap: () {},
                color: Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            Container(
              color: Color.fromARGB(154, 174, 174, 174),
              height: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the Product',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                    context: context, product: widget.product, rating: rating);
              },
            )
          ],
        ),
      ),
    );
  }
}
