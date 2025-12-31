import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/model/order_model.dart';
import 'package:flutter/material.dart';

import '../home/payment_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const String name = "order-details";

  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final OrderModel order = data['order'];
    final CarModel car = CarModel.fromJson(order.carData!);

    final bool isPaid = order.paymentStatus == 'Paid';

    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ================= Car Info =================
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Car Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        car.media.thumbnail,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      car.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),

                    Text(
                      "${car.brand} • ${car.model} • ${car.year}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const Divider(height: 30),

                    _row("Price", "\$${car.pricing.sellingPrice}"),
                    _row("Mileage", "${car.specs.mileageKm} km"),
                    _row("Fuel", car.specs.fuelType),
                    _row("Transmission", car.specs.transmission),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// ================= Order Info =================
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row("Order ID", "#${order.sId?.substring(0, 8)}"),
                    _row("Delivery", order.deliveryOption),
                    _row("Order Amount", "\$${order.totalAmount}"),
                    _row(
                      "Payment Status",
                      order.paymentStatus,
                      valueColor: isPaid ? Colors.green : Colors.orange,
                    ),
                    _row("Customer", order.fullName),
                    _row("Phone", order.phone),
                    _row("Location", order.location),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// ================= Action Button =================
            SizedBox(
              width: double.infinity,
              child: isPaid
                  ? FilledButton(
                onPressed: null,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Payment Completed"),
              )
                  : FilledButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PaymentScreen.name,
                    arguments: {
                      "order": order,
                      "car": car,
                      "totalPrice": order.totalAmount,
                      "fullName": order.fullName,
                      "email": order.email,
                      "phone": order.phone,
                      "location": order.location,
                      "deliveryOption": order.deliveryOption,
                    },
                  );
                },
                child: const Text("Pay Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: valueColor ?? Colors.grey),
          ),
        ],
      ),
    );
  }
}
