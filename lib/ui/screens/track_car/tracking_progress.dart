import 'package:car_hub/providers/order_tracking_provider.dart';
import 'package:car_hub/ui/widgets/tracking_progress_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackingProgress extends StatefulWidget {
  const TrackingProgress({super.key});

  static String name = "tracking-progress";

  @override
  State<TrackingProgress> createState() => _TrackingProgressState();
}

class _TrackingProgressState extends State<TrackingProgress> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final trackingCode = ModalRoute.of(context)?.settings.arguments as String?;
      if (trackingCode != null && trackingCode.isNotEmpty) {
        context.read<OrderTrackingProvider>().getTrackingProgress(trackingCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track your car")),
      body: Consumer<OrderTrackingProvider>(
        builder: (context, trackingProvider, child) {
          // Show loading
          if (trackingProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error
          if (trackingProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    trackingProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final trackingCode = ModalRoute.of(context)?.settings.arguments as String?;
                      if (trackingCode != null) {
                        trackingProvider.getTrackingProgress(trackingCode);
                      }
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // Check if data is empty
          final displayData = trackingProvider.trackingTimeline;



          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Delivery to Port",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: displayData.length,
                  itemBuilder: (context, index) {
                    final status = displayData[index];
                    return TrackingProgressTile(
                      title: status.title,
                      subtitle: status.subtitle,
                      icon: IconData(status.iconCodePoint,
                          fontFamily: 'MaterialIcons'),
                      isFirst: status.isFirst,
                      isLast: status.isLast,
                      isPast: status.isPast,
                      isCurrent: status.isCurrent,
                      isUpcoming: status.isUpcoming,
                    );
                  },
                  padding: const EdgeInsets.all(20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }}