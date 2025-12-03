import 'package:car_hub/ui/widgets/car_card.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});
  static String name = "search-result";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result",style: TextTheme.of(context).titleMedium,),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{},
        child: ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: 10,
          itemBuilder: (context, index) => CarCard(),
          separatorBuilder: (context, index) => SizedBox(height: 10,),
        ),
      ),
    );
  }
}
