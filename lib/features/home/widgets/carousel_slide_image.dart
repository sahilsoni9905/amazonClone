import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselImagesWidgets = [];
    List<String> carouselImages = GlobalVariables.carouselImages;

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

    return CarouselSlider(
      items: carouselImagesWidgets,
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
