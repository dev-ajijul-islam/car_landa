import 'package:car_hub/ui/screens/favorite_screen.dart';
import 'package:car_hub/ui/screens/home/home_screen.dart';
import 'package:car_hub/ui/screens/profile/profile.dart';
import 'package:car_hub/ui/screens/track_car/track_car.dart';
import 'package:car_hub/ui/screens/view_cars/view_cars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static String name = "main-layout";
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> screens = [
    const HomeScreen(),
    const ViewCars(),
    const TrackCar(),
    const FavoriteScreen(),
    const Profile(),
  ];

  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          elevation: 5,
          currentIndex: currentScreen,
          onTap: (index) {
            setState(() {
              currentScreen = index;
            });
          },
          selectedItemColor: ColorScheme.of(context).primary,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.home),
              icon: const Icon(Icons.home_outlined),
              label: "main_layout.home".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.directions_car_filled_sharp),
              icon: const Icon(Icons.directions_car_sharp),
              label: "main_layout.view_car".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.location_on),
              icon: const Icon(Icons.location_on_outlined),
              label: "main_layout.track_car".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.favorite),
              icon: const Icon(Icons.favorite_border_outlined),
              label: "main_layout.favorite".tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.person_2),
              icon: const Icon(Icons.person_2_outlined),
              label: "main_layout.profile".tr(),
            ),
          ],
        ),
      ),
    );
  }
}