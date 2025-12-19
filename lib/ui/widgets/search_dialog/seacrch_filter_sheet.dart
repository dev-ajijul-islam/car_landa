import 'package:car_hub/providers/advance_search_provider.dart';
import 'package:car_hub/providers/car_fuel_type_provider.dart';
import 'package:car_hub/providers/car_locations_provider.dart';
import 'package:car_hub/providers/car_models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_hub/providers/car_brands_provider.dart';

searchFilter(BuildContext context) {
  RangeValues values = RangeValues(1000, 1000000);
  RangeValues carYears = RangeValues(2000, 2025);

  context.read<CarBrandsProvider>().getAllCarBrands();
  context.read<CarModelsProvider>().getAllCarModels();
  context.read<CarFuelTypeProvider>().getCarFuelTypes();
  context.read<CarLocationsProvider>().getcarLocations();

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
                        initialSelection: context
                            .read<AdvanceSearchProvider>()
                            .brand,
                        enableSearch: true,
                        enableFilter: true,
                        menuStyle: MenuStyle(
                          fixedSize: WidgetStatePropertyAll(Size(30, 400)),
                        ),
                        selectedTrailingIcon: Icon(Icons.check),
                        onSelected: (value) {
                          context.read<CarModelsProvider>().getAllCarModels(
                            brand: value,
                          );
                          context.read<CarFuelTypeProvider>().getCarFuelTypes(
                            brand: value,
                            model: context.read<AdvanceSearchProvider>().model,
                          );
                          context.read<CarLocationsProvider>().getcarLocations(
                            brand: value,
                            model: context.read<AdvanceSearchProvider>().model,
                            fuelType: context
                                .read<AdvanceSearchProvider>()
                                .model,
                          );
                          context.read<AdvanceSearchProvider>().brand = value;
                        },
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
                  Consumer<CarModelsProvider>(
                    builder: (context, provider, child) {
                      return DropdownMenu(
                        initialSelection: context
                            .read<AdvanceSearchProvider>()
                            .model,
                        onSelected: (value) {
                          context.read<AdvanceSearchProvider>().model = value;
                          context.read<CarFuelTypeProvider>().getCarFuelTypes(
                            brand: context.read<AdvanceSearchProvider>().brand,
                            model: context.read<AdvanceSearchProvider>().model,
                          );
                          context.read<CarLocationsProvider>().getcarLocations(
                            brand: context.read<AdvanceSearchProvider>().brand,
                            model: context.read<AdvanceSearchProvider>().model,
                            fuelType: context
                                .read<AdvanceSearchProvider>()
                                .fuelType,
                          );
                        },
                        selectedTrailingIcon: Icon(Icons.check),
                        inputDecorationTheme: InputDecorationThemeData(
                          filled: true,
                          fillColor: Colors.white54,
                        ),
                        hintText: "Select car model",
                        width: MediaQuery.of(context).size.width,
                        leadingIcon: Icon(Icons.directions_car_outlined),
                        dropdownMenuEntries: List.generate(
                          provider.carModels.length,
                          (index) => DropdownMenuEntry(
                            value: provider.carModels[index],
                            label: provider.carModels[index],
                          ),
                        ),
                      );
                    },
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
                      "Fuel type",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  Consumer<CarFuelTypeProvider>(
                    builder: (context, provider, child) {
                      return DropdownMenu(
                        onSelected: (value) {
                          context.read<AdvanceSearchProvider>().fuelType =
                              value;
                          context.read<CarLocationsProvider>().getcarLocations(
                            model: context.read<AdvanceSearchProvider>().model,
                            brand: context.read<AdvanceSearchProvider>().brand,
                            fuelType: value,
                          );
                        },
                        initialSelection: context
                            .read<AdvanceSearchProvider>()
                            .fuelType,
                        selectedTrailingIcon: Icon(Icons.check),
                        inputDecorationTheme: InputDecorationThemeData(
                          filled: true,
                          fillColor: Colors.white54,
                        ),
                        hintText: "Select by fuel type",
                        width: MediaQuery.of(context).size.width,
                        leadingIcon: Icon(Icons.hourglass_bottom),
                        dropdownMenuEntries: List.generate(
                          provider.carFuelTypes.length,
                          (index) => DropdownMenuEntry(
                            value: provider.carFuelTypes[index],
                            label: provider.carFuelTypes[index],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Location",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                  Consumer<CarLocationsProvider>(
                    builder: (context, provider, child) {
                      return DropdownMenu(
                        onSelected: (value) {
                          context.read<AdvanceSearchProvider>().location =
                              value;
                        },
                        initialSelection: context
                            .read<AdvanceSearchProvider>()
                            .location,
                        selectedTrailingIcon: Icon(Icons.check),
                        inputDecorationTheme: InputDecorationThemeData(
                          filled: true,
                          fillColor: Colors.white54,
                        ),
                        hintText: "Select by location",
                        width: MediaQuery.of(context).size.width,
                        leadingIcon: Icon(Icons.location_on_outlined),
                        dropdownMenuEntries: List.generate(
                          provider.carLocations.length,
                          (index) => DropdownMenuEntry(
                            value: provider.carLocations[index],
                            label: provider.carLocations[index],
                          ),
                        ),
                      );
                    },
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
