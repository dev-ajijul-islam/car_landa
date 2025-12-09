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
                title,
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
                child: Icon(Icons.done_outlined, size: 14),
              ),
            ],
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: isUpcoming ? Colors.grey : Colors.black54),
          ),
        ),
      ),
    );
  }
}
