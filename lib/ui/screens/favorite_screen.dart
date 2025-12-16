import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Car"),
      ),
      // body: ListView.separated(
      //   itemCount: 10,
      //   padding: EdgeInsets.all(20),
      //   itemBuilder: (context, index) => CarCard(),
      //   separatorBuilder: (context, index) => SizedBox(height: 10,),
      // ),
    );
  }
}
