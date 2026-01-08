import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          TrackingProgress.name,
          arguments: order.sId,
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: 115,
          child: Row(
            children: [
              Expanded(
                child: order.carData?["media"]["thumbnail"] != null
                    ? Image.network(
                        order.carData?["media"]["thumbnail"],
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.asset(
                        AssetsFilePaths.carBg,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        order.carData?["title"],
                        style: TextTheme.of(
                          context,
                        ).titleMedium?.copyWith(fontSize: 18),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${"history.tracking_id".tr()}: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "#${order.sId?.substring(0, 10)}..",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "${"history.date".tr()}: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: order.createdAt != null
                                  ? DateFormat(
                                      'dd MMM yyyy • hh:mm a',
                                    ).format(order.createdAt!)
                                  : '',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 30),
                          backgroundColor: Colors.blue.withAlpha(100),
                        ),
                        child: Text(
                          getOrderStatus(order),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getOrderStatus(OrderModel order) {
    if (order.tracking.isEmpty) return 'status.in_progress'.tr();

    final current = order.tracking.firstWhere(
      (t) => t.isCurrent,
      orElse: () => order.tracking.first,
    );

    if (current.isCurrent) {
      return current.title;
    }

    final delivered = order.tracking.any((t) => t.isLast && t.isPast);
    if (delivered) {
      return 'status.delivered'.tr();
    }

    final canceled = order.tracking.any(
      (t) => t.title.toLowerCase() == 'canceled',
    );
    if (canceled) {
      return 'status.canceled'.tr();
    }

    return 'status.in_progress'.tr();
  }
}
