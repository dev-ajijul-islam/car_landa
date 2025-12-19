import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_hub/providers/car_brands_provider.dart';

searchFilter(BuildContext context) {
  RangeValues values = RangeValues(1000, 1000000);
  RangeValues carYears = RangeValues(2000, 2025);

  context.read<CarBrandsProvider>().getAllCarBrands();

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.hardEdge,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.only(top: 20),
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close_outlined),
                      ),
                      Text("Filter", style: TextTheme.of(context).titleMedium),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Brand",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  Consumer<CarBrandsProvider>(
                    builder: (context, provider, child) {
                      return DropdownMenu(
                        inputDecorationTheme: InputDecorationThemeData(
                          filled: true,
                          fillColor: Colors.white54,
                        ),
                        hintText: "Select car brand",
                        width: MediaQuery.of(context).size.width,
                        leadingIcon: Icon(Icons.directions_car_outlined),
                        dropdownMenuEntries: List.generate(
                          provider.carBrands.length,
                          (index) => DropdownMenuEntry(
                            value: provider.carBrands[index],
                            label: provider.carBrands[index],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Model",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  DropdownMenu(
                    inputDecorationTheme: InputDecorationThemeData(
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                    hintText: "Select car model",
                    width: MediaQuery.of(context).size.width,
                    leadingIcon: Icon(Icons.directions_car_outlined),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "value", label: "Honda CR-V"),
                      DropdownMenuEntry(value: "value", label: "Honda CR-V"),
                      DropdownMenuEntry(value: "value", label: "Honda CR-V"),
                      DropdownMenuEntry(value: "value", label: "Honda CR-V"),
                      DropdownMenuEntry(value: "value", label: "Honda CR-V"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Price",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "\$${values.start.toStringAsFixed(0)}",
                                style: TextTheme.of(context).bodyLarge,
                              ),
                              Text(
                                "\$${values.end.toStringAsFixed(0)}",
                                style: TextTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                          RangeSlider(
                            max: 1000000,
                            min: 1000,
                            values: values,
                            onChanged: (value) {
                              setState(() {
                                values = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text("Year", style: TextTheme.of(context).bodyLarge),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                carYears.start.toStringAsFixed(0),
                                style: TextTheme.of(context).bodyLarge,
                              ),
                              Text(
                                carYears.end.toStringAsFixed(0),
                                style: TextTheme.of(context).bodyLarge,
                              ),
                            ],
                          ),
                          RangeSlider(
                            max: 2025,
                            min: 2000,
                            values: carYears,
                            onChanged: (value) {
                              setState(() {
                                carYears = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Brand",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  DropdownMenu(
                    inputDecorationTheme: InputDecorationThemeData(
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                    hintText: "Select by fuel type",
                    width: MediaQuery.of(context).size.width,
                    leadingIcon: Icon(Icons.hourglass_bottom),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "value", label: "Diesel"),
                      DropdownMenuEntry(value: "value", label: "Diesel"),
                      DropdownMenuEntry(value: "value", label: "Diesel"),
                      DropdownMenuEntry(value: "value", label: "Diesel"),
                      DropdownMenuEntry(value: "value", label: "Diesel"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Brand",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  DropdownMenu(
                    inputDecorationTheme: InputDecorationThemeData(
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                    hintText: "Select by location",
                    width: MediaQuery.of(context).size.width,
                    leadingIcon: Icon(Icons.location_on_outlined),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "value", label: "South korea"),
                      DropdownMenuEntry(value: "value", label: "South korea"),
                      DropdownMenuEntry(value: "value", label: "South korea"),
                      DropdownMenuEntry(value: "value", label: "South korea"),
                      DropdownMenuEntry(value: "value", label: "South korea"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
