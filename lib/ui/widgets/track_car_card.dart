import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackCarCard extends StatefulWidget {
  const TrackCarCard({super.key});

  @override
  State<TrackCarCard> createState() => _TrackCarCardState();
}

class _TrackCarCardState extends State<TrackCarCard> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CarDetailsScreen.name);
      },
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AssetsFilePaths.car2,
                fit: BoxFit.fill,
                width: double.maxFinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Column(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Audi . RS Q8 . TFSI V8",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Paid",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5,
                      children: [
                        Row(
                          children: [
                            Text("Year : 2025"),
                            Text("Mileage : 1700km"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("#1k3j5"),
                            IconButton(
                              onPressed: () {
                                ClipboardData(text: "text");
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text("Ras AI Khor, Dubai"),
                      ],
                    ),
                    FilledButton(
                      onPressed: _trackCarDialog,
                      child: Text("Track"),
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

  void _trackCarDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Enter code", style: TextTheme.of(context).titleMedium),
        content: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Enter your tracking code"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, TrackingProgress.name);
              },
              child: Text("Track your car"),
            ),
          ],
        ),
      ),
    );
  }
}
