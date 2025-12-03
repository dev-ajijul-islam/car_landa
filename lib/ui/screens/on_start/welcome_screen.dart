import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';

import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static String name = "welcome-screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  List sliders = [1, 2, 3, 4, 5];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(
            fit: BoxFit.fill,
            AssetsFilePaths.svgWelcomeBg,
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarouselSlider(
                      carouselController: _carouselSliderController,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.height - 200,
                        pageSnapping: true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) => setState(() {
                          currentIndex = index;
                        }),
                      ),
                      items: sliders.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 80),
                                SizedBox(
                                  width: 300,
                                  child: Image.asset(AssetsFilePaths.car1),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Welcome to CarLanda",
                                        style: TextTheme.of(context).bodyLarge,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Your gateway to premium vehicles, delivered from around the world ",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: FilledButton(
                        onPressed: () {
                          if (currentIndex != sliders.indexOf(sliders.last)) {
                            _carouselSliderController.nextPage();
                          } else {
                            onTapGetStarted();
                          }
                        },
                        child: Text(
                          (currentIndex == sliders.indexOf(sliders.last)
                              ? "Get Started"
                              : "Next"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                sliders.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      _carouselSliderController.animateToPage(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? ColorScheme.of(context).primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width:
                          MediaQuery.of(context).size.width / sliders.length -
                          50,
                      height: 5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: onTapSkipButton,
              child: Text("Skip"),
            ),
          ),
        ],
      ),
    );
  }

  onTapSkipButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  onTapGetStarted() {
    Navigator.pushNamed(context, SignInScreen.name);
  }
}
