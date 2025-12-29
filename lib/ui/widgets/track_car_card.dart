import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackCarCard extends StatefulWidget {
  final OrderModel order;

  const TrackCarCard({super.key, required this.order});

  @override
  State<TrackCarCard> createState() => _TrackCarCardState();
}

class _TrackCarCardState extends State<TrackCarCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CarDetailsScreen.name,
          arguments: widget.order.carId,
        );
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
              widget.order.carData!["media"]["thumbnail"] == null
                  ? Image.asset(
                      AssetsFilePaths.car2,
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                    )
                  : Image.network(
                      widget.order.carData!["media"]["thumbnail"],
                      fit: BoxFit.fill,
                      width: double.maxFinite,
                      height: 220,
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
                        Expanded(
                          child: Text(
                            "${widget.order.carData!["title"] ?? 'N/A'}",
                            style: TextTheme.of(context).titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.order.paymentStatus,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: widget.order.paymentStatus == 'Paid'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            Text(
                              "\$${widget.order.totalAmount}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery: ${widget.order.deliveryOption}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "#${widget.order.sId?.substring(0, 6) ?? 'N/A'}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget.order.sId != null) {
                                  Clipboard.setData(
                                    ClipboardData(text: widget.order.sId!),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Order ID copied to clipboard",
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.copy, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.order.location,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () => _trackCarDialog(widget.order.sId),
                      child: const Text("Track"),
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

  void _trackCarDialog(String? orderId) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Enter tracking code",
          style: TextTheme.of(context).titleMedium,
        ),
        content: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: "Enter your tracking code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                final trackingCode = codeController.text.trim();
                final codeToUse = trackingCode.isNotEmpty
                    ? trackingCode
                    : orderId;

                if (codeToUse != null && codeToUse.isNotEmpty) {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    TrackingProgress.name,
                    arguments: codeToUse,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid tracking code"),
                    ),
                  );
                }
              },
              child: const Text("Track your car"),
            ),
          ],
        ),
      ),
    );
  }
}
