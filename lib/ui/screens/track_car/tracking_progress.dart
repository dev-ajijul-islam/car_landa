import 'package:car_hub/ui/widgets/tracking_progress_tile.dart';
import 'package:flutter/material.dart';

class TrackingProgress extends StatelessWidget {
  TrackingProgress({super.key});

  static String name = "tracking-progress";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track your car")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Delivery to Port",style: TextTheme.of(context).titleMedium),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trackingData.length,
              itemBuilder: (context, index) => TrackingProgressTile(
                title: trackingData[index]["title"],
                subtitle: trackingData[index]["subtitle"],
                icon: trackingData[index]["icon"],
                isFirst: trackingData[index]["isFirst"],
                isLast: trackingData[index]["isLast"],
                isPast: trackingData[index]["isPast"],
                isCurrent: trackingData[index]["isCurrent"],
                isUpcoming: trackingData[index]["isUpcoming"],

              ),
              padding: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> trackingData = [
    {
      "title": "Payment Confirmed",
      "subtitle":
          "We've received your payment and signed the purchase contract.",
      "icon": Icons.receipt_long,
      "isFirst": true,
      "isLast": false,
      "isPast": true,
      "isCurrent": false,
      "isUpcoming": false,
    },
    {
      "title": "Vehicle Shipped",
      "subtitle": "Your vehicle has been loaded onto the vessel.",
      "icon": Icons.local_shipping,
      "isFirst": false,
      "isLast": false,
      "isPast": true,
      "isCurrent": false,
      "isUpcoming": false,
    },
    {
      "title": "Vessel Departure",
      "subtitle": "The ship carrying your car has departed the port.",
      "icon": Icons.directions_boat,
      "isFirst": false,
      "isLast": false,
      "isPast": true,
      "isCurrent": false,
      "isUpcoming": false,
    },
    {
      "title": "Arrived at Port",
      "subtitle": "Your car has reached the destination port.",
      "icon": Icons.anchor,
      "isFirst": false,
      "isLast": false,
      "isPast": false,
      "isCurrent": true,
      "isUpcoming": false,
    },
    {
      "title": "Custom Clearance",
      "subtitle": "Customs procedures are underway.",
      "icon": Icons.fact_check,
      "isFirst": false,
      "isLast": false,
      "isPast": false,
      "isCurrent": false,
      "isUpcoming": true,
    },
    {
      "title": "Ready for Delivery",
      "subtitle": "Your car is ready to be delivered.",
      "icon": Icons.directions_car_filled,
      "isFirst": false,
      "isLast": false,
      "isPast": false,
      "isCurrent": false,
      "isUpcoming": true,
    },
    {
      "title": "Delivered",
      "subtitle": "Congratulations! Your vehicle has been delivered.",
      "icon": Icons.check_circle,
      "isFirst": false,
      "isLast": true,
      "isPast": false,
      "isCurrent": false,
      "isUpcoming": true,
    },
  ];
}
