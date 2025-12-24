import 'package:car_hub/providers/favorite_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<FavoriteProvider>().getFavoriteCars();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoriteProvider>().getFavoriteCars();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Favorite Car")),
        body: Consumer<FavoriteProvider>(
          builder: (context, provider, child) => provider.favoriteCars.isEmpty
              ? Center(child: Text("No favorite car found"))
              : Visibility(
                  visible: provider.isLoading == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    itemCount: provider.favoriteCars.length,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) =>
                        CarCard(car: provider.favoriteCars[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                ),
        ),
      ),
    );
  }
}
