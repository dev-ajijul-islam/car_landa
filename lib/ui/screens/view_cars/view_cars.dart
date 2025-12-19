import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/view_cars_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCars extends StatefulWidget {
  const ViewCars({super.key});

  @override
  State<ViewCars> createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<ViewCarsProvider>().getAllCars();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Cars (${context.watch<ViewCarsProvider>().cars.length})",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ViewCarsProvider>().getAllCars();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              TextField(
                onChanged: (value) {
                  context.read<ViewCarsProvider>().getcarByTitle(title: value);
                },

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
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
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
              Expanded(
                child: Consumer<ViewCarsProvider>(
                  builder: (context, provider, child) {
                    return provider.errorMessage == null
                        ? Visibility(
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            visible: provider.isLoading == false,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemCount: provider.cars.length,
                              itemBuilder: (context, index) {
                                CarModel car = provider.cars[index];
                                return CarCard(car: car);
                              },
                            ),
                          )
                        : Center(child: Text(provider.errorMessage.toString()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
