import 'package:car_hub/providers/advance_search_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});
  static String name = "search-result";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search_result.title".tr(), style: TextTheme.of(context).titleMedium),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Consumer<AdvanceSearchProvider>(
          builder: (context, provider, child) => ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: provider.searchedCars.length,
            itemBuilder: (context, index) =>
                CarCard(car: provider.searchedCars[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),
      ),
    );
  }
}