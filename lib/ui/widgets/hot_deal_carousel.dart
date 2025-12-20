import 'package:car_hub/providers/hot_deal_car_provider.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotDealCarousel extends StatelessWidget {
  const HotDealCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotDealCarProvider>(
      builder: (context, provider, child) {
        return CarouselSlider(
          items: provider.hotDealCars.map((s) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CarDetailsScreen.name,
                    arguments: s.sId,
                  );
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Card(
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,

                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                s.media.thumbnail,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    AssetsFilePaths.car2,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(color: Colors.black26),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Hot Deal",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(viewportFraction: 0.7, autoPlay: true),
        );
      },
    );
  }
}
