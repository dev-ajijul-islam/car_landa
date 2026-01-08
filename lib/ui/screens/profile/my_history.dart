import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/providers/track_car_provider.dart';
import 'package:car_hub/ui/widgets/history_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  static String name = "my-history";

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  final List<String> historySections = ["history.in_progress".tr(), "history.delivered".tr(), "history.canceled".tr()];
  int selectedChip = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackCarProvider>().getMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("history.title".tr())),
      body: Column(
        children: [
          // Chips for filtering
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: historySections.length,
              separatorBuilder: (_, __) => const SizedBox(width: 0),
              itemBuilder: (context, index) {
                final isSelected = selectedChip == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ChoiceChip(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    showCheckmark: false,
                    label: Text(
                      historySections[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedChip = index;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Orders list
          Expanded(
            child: Consumer<TrackCarProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage!));
                }

                // Filter orders based on tracking
                List<OrderModel> filteredList = [];
                switch (selectedChip) {
                  case 0: // In Progress
                    filteredList = provider.userOrders
                        .where(
                          (o) => o.tracking.any(
                            (t) => t.isCurrent || t.isUpcoming,
                      ),
                    )
                        .toList();
                    break;
                  case 1: // Delivered
                    filteredList = provider.userOrders
                        .where(
                          (o) =>
                      o.tracking.isNotEmpty &&
                          o.tracking.last.isLast &&
                          o.tracking.last.isPast,
                    )
                        .toList();
                    break;
                  case 2: // Canceled
                    filteredList = provider.userOrders
                        .where(
                          (o) => o.tracking.any(
                            (t) => t.title.toLowerCase() == "canceled",
                      ),
                    )
                        .toList();
                    break;
                }

                if (filteredList.isEmpty) {
                  return Center(child: Text("history.no_orders_found".tr()));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final OrderModel item = filteredList[index];

                    return HistoryCard(order: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}