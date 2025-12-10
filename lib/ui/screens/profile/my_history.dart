import 'package:flutter/material.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  static String name = "my-history";

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  final List<String> historySections = ["In Progress", "Delivered", "Canceled"];

  int selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My History")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChoiceChip(
                    showCheckmark: false,
                    color: WidgetStateColor.resolveWith(
                      (states) => selectedChip == index
                          ? ColorScheme.of(context).primary
                          : Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectedChip = index;
                      });
                    },
                    label: Text(
                      historySections[index],
                      style: TextStyle(
                        color: selectedChip == index
                            ? Colors.white
                            : ColorScheme.of(context).primary,
                      ),
                    ),
                    selected: selectedChip == index,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: historySections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
