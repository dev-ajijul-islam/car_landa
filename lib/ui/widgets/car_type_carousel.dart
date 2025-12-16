import 'package:car_hub/providers/car_types_provider.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarTypeCarousel extends StatelessWidget {
  const CarTypeCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CarTypesProvider>(
      builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Shop by car type",
              style: TextTheme.of(context).titleMedium,
            ),
          ),
          SizedBox(height: 10,),
          CarouselSlider(
            items: provider.carTypes.map((c) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                color: Colors.white,
                child: Center(
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AssetsFilePaths.carTypeImage1),
                      Text(
                        c,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              padEnds: false,
              pageSnapping: false,
              initialPage: 0,
              aspectRatio: 4.5,
              viewportFraction: 0.27,
              enableInfiniteScroll: false,
            ),
          ),
        ],
      );},
    );
  }
}