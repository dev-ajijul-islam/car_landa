import 'package:car_hub/providers/single_car_provider.dart';
import 'package:car_hub/ui/widgets/delivery_option_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});
  static String name = "car-details";

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  bool isFav = false;


  @override
  void initState() {
    _loadInitialData();
    super.initState();
  }

  _loadInitialData(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final carId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<SingleCarProvider>().getCarById(carId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SingleCarProvider>();
    final car = provider.car;

    if (provider.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (car == null) {
      return const Scaffold(
        body: Center(child: Text("Car not found")),
      );
    }

    /// 🔹 Key specs mapped from model
    final specs = [
      _spec("Mileage", "${car.specs.mileageKm} km"),
      _spec("Engine Power", "${car.specs.enginePowerHp} HP"),
      _spec("Fuel Type", car.specs.fuelType),
      _spec("Cylinders", car.specs.cylinders.toString()),
      _spec("Transmission", car.specs.transmission),
      _spec("Seats", car.specs.seats.toString()),
      _spec("Interior Color", car.specs.interiorColor),
      _spec("Exterior Color", car.specs.exteriorColor),
      _spec("Shipping Cost", "\$${car.costs.shipping}"),
      _spec("Custom Clearance", "\$${car.costs.customClearance}"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(car.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                elevation: 0,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          car.media.thumbnail.isNotEmpty
                              ? car.media.thumbnail
                              : 'https://via.placeholder.com/400x250',
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AssetsFilePaths.car2,
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: 200,
                            );
                          },
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() => isFav = !isFav);
                            },
                            icon: Icon(
                              isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// TITLE + PRICE
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              car.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (car.pricing.discount != null)
                                Text(
                                  "\$${car.pricing.originalPrice}",
                                  style: const TextStyle(
                                    decoration:
                                    TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              Text(
                                "\$${car.pricing.sellingPrice} ${car.pricing.currency}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// LOCATION + YEAR
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Year : ${car.year}"),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                "${car.location.city}, ${car.location.country}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// KEY SPECIFICATIONS
              Text(
                "Key Specification",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: specs.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.4,
                ),
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        specs[i]["title"]!,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specs[i]["value"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),

              const SizedBox(height: 10),

              /// DESCRIPTION
              Text(
                "Details",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(car.description),

              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => deliveryDialog(context),
                child: const Text("Buy Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> _spec(String title, String value) =>
      {"title": title, "value": value};
}
