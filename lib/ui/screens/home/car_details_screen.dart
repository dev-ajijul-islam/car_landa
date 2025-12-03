import 'package:car_hub/ui/widgets/delivery_option_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});
  static String name = "car-details";

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  List<Map<String, String>> carDetails = [
    {"title": "Mileage", "value": "40,000 km"},
    {"title": "Engine Power", "value": "250HP"},
    {"title": "Fuel Type", "value": "Petrol"},
    {"title": "Number of Cylinder", "value": "6"},
    {"title": "Transmission", "value": "Automatic"},
    {"title": "Number of Seats", "value": "5"},
    {"title": "Interior Color", "value": "Black"},
    {"title": "Exterior Color", "value": "Blue"},
    {"title": "Shipping Cost", "value": "\$2500"},
    {"title": "Custom Clearance Cost", "value": "\$1000"},
  ];

  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car details", style: TextTheme.of(context).titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            AssetsFilePaths.car2,
                            fit: BoxFit.fill,
                            width: double.maxFinite,
                          ),
                          Positioned(
                            top: 5,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isFav = !isFav;
                                });
                              },
                              icon: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: ColorScheme.of(context).primary,
                              ),
                            ),
                          ),
                        ],
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
                                      "\$24000 ",
                                      style: TextTheme.of(context).bodyMedium
                                          ?.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 17,
                                            color: Colors.grey,
                                          ),
                                    ),
                                    Text("\$22000 "),
                                  ],
                                ),
                              ],
                            ),
                            Row(spacing: 15, children: [Text("Year : 2025")]),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text("Ras AI Khor, Dubai"),
                              ],
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [Icon(Icons.phone_outlined)],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [Icon(Icons.message)],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [Icon(Icons.whatshot)],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Key Specification",
                style: TextTheme.of(context).titleMedium,
              ),
              SizedBox(height: 10),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: carDetails.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.4,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carDetails[index]["title"]!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        carDetails[index]["value"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(color: Colors.grey),
                    ],
                  );
                },
              ),
              Text("Details", style: TextTheme.of(context).titleMedium),
              Text(
                "Experience refined luxury and everyday performance with the 2021 Audi Q5. This premium SUV features a powerful 2.0L turbocharged engine with 261 horsepower and Audi’s signature Quattro all-wheel drive,",
              ),
              SizedBox(height: 10),
              FilledButton(onPressed: () {
                deliveryDialog(context);
              }, child: Text("Buy Now")),
            ],
          ),
        ),
      ),
    );
  }
}
