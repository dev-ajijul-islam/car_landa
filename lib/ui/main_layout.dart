import 'package:car_hub/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  static String name = "main-layout";
   const MainLayout({super.key});


  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  List <Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          elevation: 5,
          currentIndex: currentScreen,
          onTap: (index){
            setState(() {
              currentScreen = index;
            });

          },

          selectedItemColor: ColorScheme.of(context).primary,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.directions_car_filled_sharp),
              icon: Icon(Icons.directions_car_sharp),
              label: "View car",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.location_on),
              icon: Icon(Icons.location_on_outlined),
              label: "Track car",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border_outlined),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
