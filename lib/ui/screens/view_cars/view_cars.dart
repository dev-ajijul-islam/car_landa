import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';

class ViewCars extends StatelessWidget {
  const ViewCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Cars")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Search",
              ),
            ),
            DropdownMenu(
              hintText: "Sort",
              enableFilter: true,
              inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              width: 150,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: "Newest to Oldest",
                  label: "Newest to Oldest",
                ),
                DropdownMenuEntry(
                  value: "Newest to Oldest",
                  label: "Newest to Oldest",
                ),
                DropdownMenuEntry(
                  value: "Newest to Oldest",
                  label: "Newest to Oldest",
                ),
                DropdownMenuEntry(
                  value: "Newest to Oldest",
                  label: "Newest to Oldest",
                ),
              ],
            ),
            // Expanded(
            //   child: ListView.separated(
            //     separatorBuilder: (context, index) => SizedBox(height: 10,),
            //     itemCount: 20,
            //     itemBuilder: (context, index) {
            //       return CarCard();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
