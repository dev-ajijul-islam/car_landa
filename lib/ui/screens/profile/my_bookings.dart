import 'package:car_hub/ui/widgets/bookings_card.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  static String name = "my-bookings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings Car"),
      ),
      body: ListView.separated(
        itemCount: 10,
        padding: EdgeInsets.all(20),
        separatorBuilder: (context, index) => SizedBox(height: 10,),
        itemBuilder: (context, index) => BookingsCard(),
      ),
    );
  }
}
