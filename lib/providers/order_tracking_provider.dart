import 'package:car_hub/data/model/tracking_status_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class OrderTrackingProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<TrackingStatusModel> trackingTimeline = [];
  String? currentOrderId;

  // Reset all data
  void reset() {
    trackingTimeline.clear();
    currentOrderId = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getTrackingProgress(String orderIdOrCode) async {
    isLoading = true;
    errorMessage = null;
    trackingTimeline.clear();
    currentOrderId = null;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getTrackingStatus(orderIdOrCode),
        token: AuthProvider.idToken,
      );

      if (response.success) {
        final body = response.body?["body"];
        if (body != null) {
          // Store order ID
          currentOrderId = body["orderId"]?.toString();

          // Parse timeline - MOST IMPORTANT PART
          if (body["statusList"] is List) {
            List<dynamic> list = body["statusList"];
            for (var item in list) {
              if (item is Map<String, dynamic>) {
                trackingTimeline.add(TrackingStatusModel.fromJson(item));
              }
            }
          }

          // If API returns empty timeline (should not happen after backend fix)
          if (trackingTimeline.isEmpty) {
            _createDefaultTimeline();
          }
        }
      } else {
        errorMessage = response.body?["message"] ?? "Invalid tracking code";
      }
    } catch (e) {
      errorMessage = "An error occurred: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fallback timeline (only if API fails)
  void _createDefaultTimeline() {
    trackingTimeline = [
      TrackingStatusModel(
        title: "Order Placed",
        subtitle: "Your order has been placed successfully.",
        iconCodePoint: Icons.receipt_long.codePoint,
        isFirst: true,
        isPast: true,
        isCurrent: false,
        isUpcoming: false,
      ),
      TrackingStatusModel(
        title: "Payment Confirmed",
        subtitle: "Payment has been received and confirmed.",
        iconCodePoint: Icons.payment.codePoint,
        isFirst: false,
        isPast: false,
        isCurrent: true,
        isUpcoming: false,
      ),
      TrackingStatusModel(
        title: "Vehicle Shipped",
        subtitle: "Your vehicle has been loaded onto the vessel.",
        iconCodePoint: Icons.local_shipping.codePoint,
        isFirst: false,
        isPast: false,
        isCurrent: false,
        isUpcoming: true,
      ),
      TrackingStatusModel(
        title: "Vessel Departure",
        subtitle: "The ship carrying your car has departed the port.",
        iconCodePoint: Icons.directions_boat.codePoint,
        isFirst: false,
        isPast: false,
        isCurrent: false,
        isUpcoming: true,
      ),
      TrackingStatusModel(
        title: "Arrived at Port",
        subtitle: "Your car has reached the destination port.",
        iconCodePoint: Icons.anchor.codePoint,
        isFirst: false,
        isPast: false,
        isCurrent: false,
        isUpcoming: true,
      ),
      TrackingStatusModel(
        title: "Custom Clearance",
        subtitle: "Customs procedures are underway.",
        iconCodePoint: Icons.fact_check.codePoint,
        isFirst: false,
        isPast: false,
        isCurrent: false,
        isUpcoming: true,
      ),
      TrackingStatusModel(
        title: "Delivered",
        subtitle: "Congratulations! Your vehicle has been delivered.",
        iconCodePoint: Icons.check_circle.codePoint,
        isFirst: false,
        isLast: true,
        isPast: false,
        isCurrent: false,
        isUpcoming: true,
      ),
    ];
  }

  // Get current status title (optional helper)
  String get currentStatusTitle {
    try {
      final current = trackingTimeline.firstWhere(
            (status) => status.isCurrent,
      );
      return current.title;
    } catch (e) {
      return "Processing";
    }
  }
}