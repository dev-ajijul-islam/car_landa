import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackingProgressTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isCurrent;
  final bool isUpcoming;

  const TrackingProgressTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isFirst = false,
    this.isLast = false,
    this.isPast = false,
    this.isCurrent = false,
    this.isUpcoming = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = ColorScheme.of(context).primary;
    final Color pastColor = Colors.green;
    final Color inactiveColor = Colors.grey.shade500;

    Color indicatorColor = ColorScheme.of(context).primary.withAlpha(100);
    if (isPast) indicatorColor = pastColor;
    if (isCurrent) indicatorColor = activeColor;

    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,

      ///  Line before
      beforeLineStyle: LineStyle(color: activeColor, thickness: 3),

      ///  Line after
      afterLineStyle: LineStyle(color: activeColor, thickness: 3),

      ///  Indicator
      indicatorStyle: IndicatorStyle(
        width: 34,
        color: (isPast || isCurrent) ? activeColor : indicatorColor,
        iconStyle: IconStyle(iconData: icon, color: Colors.white),
      ),

      ///  Right content (like screenshot)
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslatedTitle(title),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isUpcoming ? Colors.grey : Colors.black,
                ),
              ),
              CircleAvatar(
                backgroundColor: (isPast || isCurrent)
                    ? pastColor
                    : inactiveColor,
                radius: 10,
                child: const Icon(Icons.done_outlined, size: 14),
              ),
            ],
          ),
          subtitle: Text(
            getTranslatedSubtitle(subtitle),
            style: TextStyle(color: isUpcoming ? Colors.grey : Colors.black54),
          ),
        ),
      ),
    );
  }

  String getTranslatedTitle(String title) {
    // Map common tracking status titles to localization keys
    switch (title.toLowerCase()) {
      case 'order placed':
      case 'order received':
        return 'tracking_progress.order_placed'.tr();
      case 'processing':
      case 'in progress':
        return 'status.in_progress'.tr();
      case 'shipped':
      case 'departed':
        return 'tracking_progress.shipped'.tr();
      case 'in transit':
        return 'tracking_progress.in_transit'.tr();
      case 'arrived at port':
      case 'arrived at destination':
        return 'tracking_progress.arrived_at_port'.tr();
      case 'custom clearance':
        return 'car_details.custom_clearance'.tr();
      case 'delivered':
        return 'status.delivered'.tr();
      case 'canceled':
        return 'status.canceled'.tr();
      default:
        return title;
    }
  }

  String getTranslatedSubtitle(String subtitle) {
    // You can add specific subtitle translations here if needed
    // For now, just return the subtitle as-is
    return subtitle;
  }
}