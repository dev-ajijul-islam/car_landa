import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/providers/featured_car_provider.dart';
import 'package:car_hub/ui/screens/home/notifications_screen.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:car_hub/ui/widgets/help_chat_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:car_hub/ui/widgets/search_dialog/search_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<AuthProvider>().currentUser;
    final featuredCarProvider = context.watch<FeaturedCarProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (featuredCarProvider.featuredCars.isEmpty &&
          !featuredCarProvider.isLoading) {
        featuredCarProvider.getFeaturedCar();
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          openChatDialog(context: context);
        },
        child: Icon(Icons.support_agent_outlined),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<FeaturedCarProvider>().getFeaturedCar();
        },
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
                  if (user != null) ...[
                    Visibility(
                      visible:
                          context.watch<AuthProvider>().currentUser != null,
                      child: Positioned(
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
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: user.photoURL != null
                                          ? NetworkImage(
                                              user.photoURL.toString(),
                                            )
                                          : AssetImage(
                                              AssetsFilePaths.dummyProfile,
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hello, ${user.displayName}",
                                          style: TextTheme.of(context)
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 17,
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
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      NotificationsScreen.name,
                                    );
                                  },
                                  icon: Icon(Icons.notifications_outlined),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  Positioned(
                    top: 90,
                    right: 15,
                    child: Image.asset(width: 240, AssetsFilePaths.car2),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onTap: () {
                    _onTapSearchField(context);
                  },
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
                          style: TextTheme.of(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                options: CarouselOptions(viewportFraction: 0.7, autoPlay: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Shop by car type",
                  style: TextTheme.of(context).titleMedium,
                ),
              ),
              SizedBox(height: 10),
              CarouselSlider(
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((c) {
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


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Featured car",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),


                    if (featuredCarProvider.isLoading &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      ),


                    if (featuredCarProvider.errorMessage != null &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text(
                              "Failed to load featured cars",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                featuredCarProvider.getFeaturedCar();
                              },
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      ),


                    if (!featuredCarProvider.isLoading &&
                        featuredCarProvider.errorMessage == null &&
                        featuredCarProvider.featuredCars.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text("No featured cars available"),
                        ),
                      ),


                    if (featuredCarProvider.featuredCars.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: featuredCarProvider.featuredCars.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final car = featuredCarProvider.featuredCars[index];
                          return CarCard(car: car,);
                        },
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _onTapSearchField(context) {
    searchDialog(context);
  }
}
