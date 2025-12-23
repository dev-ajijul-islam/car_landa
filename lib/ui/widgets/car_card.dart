import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/favorite_provider.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarCard extends StatefulWidget {
  final CarModel car;

  const CarCard({super.key, required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final hasDiscount = car.pricing.discount != null;
    final discount = car.pricing.discount;

    double discountAmount = 0;
    if (hasDiscount && discount != null) {
      if (discount.type == "percentage") {
        discountAmount = car.pricing.originalPrice * (discount.value / 100);
      } else {
        discountAmount = discount.value.toDouble();
      }
    }
    final finalPrice = car.pricing.originalPrice - discountAmount;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CarDetailsScreen.name, arguments: car.sId);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(0),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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

                  // Hot deal badge
                  if (car.flags.isHotDeal)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "HOT DEAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Featured badge
                  if (car.flags.isFeatured && !car.flags.isHotDeal)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "FEATURED",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Favorite button
                  Positioned(
                    top: 5,
                    right: 0,
                    child: Consumer<FavoriteProvider>(
                      builder: (context, provider, child) => IconButton(
                        onPressed: () async {
                          setState(() {
                            isFav = !isFav;
                          });
                          final response = await provider.createFavorite(
                            carId: car.sId,
                          );
                          print("------------------------------------${response.body}");
                        },
                        icon: provider.isLoading
                            ? Loading()
                            : Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: ColorScheme.of(context).primary,
                              ),
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
                    // Title and Price row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${car.brand} . ${car.model} . ${car.year}",
                            style: TextTheme.of(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Original price with strikethrough if discount exists
                            if (hasDiscount)
                              Text(
                                "${car.pricing.currency} ${car.pricing.originalPrice.toStringAsFixed(0)}",
                                style: TextTheme.of(context).bodyMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                              ),
                            // Final price
                            Text(
                              "${car.pricing.currency} ${finalPrice.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorScheme.of(context).primary,
                              ),
                            ),
                            // Discount percentage
                            if (hasDiscount && discount?.type == "percentage")
                              Text(
                                "${discount?.value}% OFF",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 5),

                    // Specs row
                    Row(
                      spacing: 15,
                      children: [
                        Text("Year : ${car.year}"),
                        Text(
                          "Mileage : ${car.specs.mileageKm.toStringAsFixed(0)}km",
                        ),
                      ],
                    ),

                    // Location row
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${car.location.city}, ${car.location.country}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Action buttons
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // Call functionality
                              if (car.inquiryContacts.call) {
                                // Implement call logic
                              }
                            },
                            child: Icon(Icons.phone_outlined, size: 20),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // Message functionality
                              if (car.inquiryContacts.message) {
                                // Implement message logic
                              }
                            },
                            child: Icon(Icons.message, size: 20),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // WhatsApp functionality
                              if (car.inquiryContacts.whatsapp) {}
                            },
                            child: Icon(Icons.whatshot, size: 20),
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
    );
  }
}
