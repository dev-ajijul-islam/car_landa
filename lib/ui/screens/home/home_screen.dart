import 'package:car_hub/providers/car_types_provider.dart';
import 'package:car_hub/providers/featured_car_provider.dart';
import 'package:car_hub/providers/hot_deal_car_provider.dart';
import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:car_hub/ui/widgets/car_type_carousel.dart';
import 'package:car_hub/ui/widgets/help_chat_dialog.dart';
import 'package:car_hub/ui/widgets/hero_banner.dart';
import 'package:car_hub/ui/widgets/hot_deal_carousel.dart';
import 'package:car_hub/ui/widgets/search_dialog/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String name = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<FeaturedCarProvider>().getFeaturedCar();
        context.read<HotDealCarProvider>().getHotDealCar();
        context.read<CarTypesProvider>().getCarTypes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          openChatDialog(context: context);
        },
        child: Icon(Icons.support_agent_outlined),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<FeaturedCarProvider>().getFeaturedCar();
        },
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              HeroBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onTap: () {
                    _onTapSearchField(context);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: "Search",
                    suffixIcon: IconButton(
                      color: ColorScheme.of(context).primary,
                      onPressed: () {},
                      icon: Icon(Icons.read_more_outlined, weight: 800),
                    ),
                  ),
                ),
              ),
              HotDealCarousel(),
              CarTypeCarousel(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Featured car",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),
                    Consumer<FeaturedCarProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return CircularProgressIndicator();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.featuredCars.length,
                          itemBuilder: (context, index) =>
                              CarCard(car: provider.featuredCars[index],),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _onTapSearchField(context) {
    searchDialog(context);
  }
}
