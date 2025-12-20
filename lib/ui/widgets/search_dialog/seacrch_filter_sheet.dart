import 'package:car_hub/providers/advance_search_provider.dart';
import 'package:car_hub/providers/car_fuel_type_provider.dart';
import 'package:car_hub/providers/car_locations_provider.dart';
import 'package:car_hub/providers/car_min_and_max_price_provider.dart';
import 'package:car_hub/providers/car_min_and_max_year_provider.dart';
import 'package:car_hub/providers/car_models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_hub/providers/car_brands_provider.dart';

searchFilter(BuildContext context) {
  context.read<CarBrandsProvider>().getAllCarBrands();
  context.read<CarModelsProvider>().getAllCarModels();
  context.read<CarFuelTypeProvider>().getCarFuelTypes();
  context.read<CarLocationsProvider>().getcarLocations();
  context.read<CarMinAndMaxPriceProvider>().getMinAndMaxPrice();
  context.read<CarMinAndMaxYearProvider>().getMinAndMaxYear();

  // --- পরিবর্তন এখানে: Provider থেকে ডাটা নিয়ে Initializing করা হয়েছে ---
  final advProvider = context.read<AdvanceSearchProvider>();

  RangeValues priceValues = RangeValues(
    advProvider.minPrice?.toDouble() ?? 100,
    advProvider.maxPrice?.toDouble() ?? 100000,
  );

  RangeValues yearValues = RangeValues(
    advProvider.minYear?.toDouble() ?? 2000,
    advProvider.maxYear?.toDouble() ?? 2025,
  );
  // -----------------------------------------------------------------

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
                    child: Consumer<CarMinAndMaxPriceProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading ||
                            provider.minAndMaxPrice.isEmpty) {
                          return const SizedBox(
                            height: 100,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        double min =
                            double.tryParse(
                              provider.minAndMaxPrice["min"].toString(),
                            ) ??
                            0;
                        double max =
                            double.tryParse(
                              provider.minAndMaxPrice["max"].toString(),
                            ) ??
                            100000;

                        RangeValues safePrice = RangeValues(
                          priceValues.start.clamp(min, max),
                          priceValues.end.clamp(min, max),
                        );

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$${safePrice.start.round()}"),
                                  Text("\$${safePrice.end.round()}"),
                                ],
                              ),
                              RangeSlider(
                                min: min,
                                max: max,
                                values: safePrice,
                                onChanged: (val) {
                                  setState(() => priceValues = val);
                                  context
                                      .read<AdvanceSearchProvider>()
                                      .maxPrice = val.end
                                      .toInt(); // Fixed logic here
                                  context
                                      .read<AdvanceSearchProvider>()
                                      .minPrice = val.start
                                      .toInt(); // Fixed logic here
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text("Year", style: TextTheme.of(context).bodyLarge),
                  ),

                  Card(
                    child: Consumer<CarMinAndMaxYearProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading ||
                            provider.minAndMaxYear.isEmpty) {
                          return const SizedBox(
                            height: 100,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        double min =
                            double.tryParse(
                              provider.minAndMaxYear["min"].toString(),
                            ) ??
                            1990;
                        double max =
                            double.tryParse(
                              provider.minAndMaxYear["max"].toString(),
                            ) ??
                            2025;

                        RangeValues safeYear = RangeValues(
                          yearValues.start.clamp(min, max),
                          yearValues.end.clamp(min, max),
                        );

                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${safeYear.start.round()}"),
                                  Text("${safeYear.end.round()}"),
                                ],
                              ),
                              RangeSlider(
                                min: min,
                                max: max,
                                values: safeYear,
                                onChanged: (val) {
                                  setState(() => yearValues = val);
                                  context
                                      .read<AdvanceSearchProvider>()
                                      .maxYear = val.end
                                      .toInt(); // Fixed logic here
                                  context
                                      .read<AdvanceSearchProvider>()
                                      .minYear = val.start
                                      .toInt(); // Fixed logic here
                                },
                              ),
                            ],
                          ),
                        );
                      },
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
