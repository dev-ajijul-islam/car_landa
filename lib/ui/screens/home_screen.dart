import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: SvgPicture.asset(
                        AssetsFilePaths.svgTriangle,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                CircleAvatar(backgroundColor: Colors.white),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello Michel",
                                      style: TextTheme.of(context).titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            height: 0,
                                          ),
                                    ),
                                    Text(
                                      "Welcome back!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: ColorScheme.of(
                                  context,
                                ).primary,
                              ),
                              color: Colors.white,
                              onPressed: () {},
                              icon: Icon(Icons.notifications_outlined),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    right: 15,
                    child: Image.asset(width: 240, AssetsFilePaths.car2),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: "Search",
                        suffixIcon: IconButton(
                          color: ColorScheme.of(context).primary,
                          onPressed: () {},
                          icon: Icon(Icons.read_more_outlined, weight: 800),
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [1, 2, 3, 4, 5].map((s) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 20,
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(AssetsFilePaths.car2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 30,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              child: Text(
                                "Hot Deal",
                                style: TextTheme.of(context).titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 0.7,
                        autoPlay: true,
                      ),
                    ),
                    Text(
                      "Shop by car type",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),
                    CarouselSlider(
                      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((c) {
                        return Card(
                          margin: EdgeInsets.only(right: 10),
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AssetsFilePaths.carTypeImage1),
                                Text(
                                  "Wagon",
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
                    SizedBox(height: 10),
                    Text(
                      "Featured car",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),

                    Column(
                      spacing: 10,
                      children: [CarCard(), CarCard(), CarCard(), CarCard()],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
