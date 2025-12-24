import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/favorite_provider.dart';
import 'package:car_hub/providers/single_car_provider.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
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
  @override
  Widget build(BuildContext context) {
    // ১. SingleCarProvider থেকে ডেটা ওয়াচ করা হচ্ছে ইনস্ট্যান্ট টগলের জন্য
    final providerCar = context.watch<SingleCarProvider>().car;

    // ২. আইডি ম্যাচ করলে প্রোভাইডারের আপডেটেড কার দেখাবে, নাহলে ইনিশিয়াল কার
    final car = (providerCar != null && providerCar.sId == widget.car.sId)
        ? providerCar
        : widget.car;

    // ৩. প্রাইস ও ডিসকাউন্ট ক্যালকুলেশন
    final hasDiscount = car.pricing.discount != null;
    final discount = car.pricing.discount;

    double discountAmount = 0;
    if (hasDiscount && discount != null) {
      discountAmount = (discount.type == "percentage")
          ? car.pricing.originalPrice * (discount.value / 100)
          : discount.value.toDouble();
    }
    final finalPrice = car.pricing.originalPrice - discountAmount;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CarDetailsScreen.name, arguments: car.sId);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
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
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      AssetsFilePaths.car2,
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      height: 200,
                    ),
                  ),

                  // Badges
                  if (car.flags.isHotDeal)
                    _buildBadge("HOT DEAL", Colors.red)
                  else if (car.flags.isFeatured)
                    _buildBadge("FEATURED", Colors.blue),

                  // Favorite button
                  Positioned(
                    top: 5,
                    right: 0,
                    child: Consumer<FavoriteProvider>(
                      builder: (context, favProvider, child) {
                        final isSingleCarLoading = context.watch<SingleCarProvider>().loading;

                        return IconButton(
                          onPressed: () async {
                            final bool currentlyFav = car.isFavorite ?? false;

                            // ফেভারিট এপিআই কল
                            final response = currentlyFav
                                ? await favProvider.deleteFavorite(carId: car.sId)
                                : await favProvider.createFavorite(carId: car.sId);

                            if (!context.mounted) return;

                            if (response.success) {
                              showSnackbarMessage(
                                context: context,
                                message: response.message,
                                color: Colors.green,
                              );

                              // 🔥 এই কলটি অন্য সব স্ক্রিনে (Home/Details) আইকন টগল নিশ্চিত করবে
                              context.read<SingleCarProvider>().getCarById(car.sId);
                            } else {
                              showSnackbarMessage(
                                context: context,
                                message: response.message,
                                color: Colors.red,
                              );
                            }
                          },
                          icon: (favProvider.isLoading || isSingleCarLoading)
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Loading(),
                          )
                              : Icon(
                            car.isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${car.brand} . ${car.model} . ${car.year}",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (hasDiscount)
                              Text(
                                "${car.pricing.currency} ${car.pricing.originalPrice.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            Text(
                              "${car.pricing.currency} ${finalPrice.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Year : ${car.year}"),
                        const SizedBox(width: 15),
                        Text("Mileage : ${car.specs.mileageKm.toStringAsFixed(0)}km"),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text("${car.location.city}, ${car.location.country}"),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildActionButtons(car),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildActionButtons(CarModel car) {
    return Row(
      children: [
        _expandedButton(Icons.phone_outlined, car.inquiryContacts.call),
        const SizedBox(width: 8),
        _expandedButton(Icons.message, car.inquiryContacts.message),
        const SizedBox(width: 8),
        _expandedButton(Icons.whatshot, car.inquiryContacts.whatsapp),
      ],
    );
  }

  Widget _expandedButton(IconData icon, bool enabled) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        onPressed: enabled ? () {} : null,
        child: Icon(icon, size: 20),
      ),
    );
  }
}