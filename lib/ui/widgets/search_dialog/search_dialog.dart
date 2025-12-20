import 'package:car_hub/providers/advance_search_provider.dart';
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

  showDialog(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Container(
        color: Colors.white,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) => onSubmit(),
                        onChanged: (value) async{
                          await context.read<AdvanceSearchProvider>().getCarsByFiltering(title: value);
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close_outlined),
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
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        minVerticalPadding: 0,
                        title: Text("Audi RS Q8 TFSI"),

                        trailing: Text(
                          "\$2400",
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorScheme.of(context).primary,
                          ),
                        ),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        leading: Image.asset(AssetsFilePaths.car2, width: 50),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
