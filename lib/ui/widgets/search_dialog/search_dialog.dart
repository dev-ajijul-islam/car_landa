import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/advance_search_provider.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/screens/home/search_result_screen.dart';
import 'package:car_hub/ui/widgets/search_dialog/seacrch_filter_sheet.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void searchDialog(BuildContext context) {
  void onTapFilterButton() {
    searchFilter(context);
  }

  void onSubmit() {
    Navigator.pushNamed(context, SearchResultScreen.name);
  }

  final TextEditingController searchController = TextEditingController();

  showDialog(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => Container(
          color: Colors.white,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        color: ColorScheme.of(context).primary,
                        onPressed: () {
                          Navigator.pop(context);
                          searchController.dispose();
                        },
                        icon: Icon(Icons.close_outlined),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onSubmitted: (value) => onSubmit(),
                          onChanged: (value) async {
                            await context
                                .read<AdvanceSearchProvider>()
                                .getCarsByFiltering(title: value);
                            searchController.dispose();
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_outlined),
                            hintText: "Search",
                            suffixIcon: IconButton(
                              color: ColorScheme.of(context).primary,
                              onPressed: onTapFilterButton,
                              icon: Icon(Icons.read_more_outlined, weight: 800),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: ColorScheme.of(context).primary,
                        onPressed: () async {
                          searchController.clear();
                          await context
                              .read<AdvanceSearchProvider>()
                              .getCarsByFiltering(title: searchController.text);
                        },
                        icon: Icon(Icons.restore_rounded),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Consumer<AdvanceSearchProvider>(
                      builder: (context, provider, child) {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            CarModel car = provider.searchedCars[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  CarDetailsScreen.name,
                                  arguments: car.sId,
                                );
                              },
                              minVerticalPadding: 0,
                              title: Text(car.title),

                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  car.media.thumbnail.isNotEmpty
                                      ? car.media.thumbnail
                                      : 'https://via.placeholder.com/400x250',

                                  width: 58,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AssetsFilePaths.car1,
                                      fit: BoxFit.cover,
                                      width: 58,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: provider.searchedCars.length.clamp(0, 10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
