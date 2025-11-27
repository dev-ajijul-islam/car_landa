import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static String name = "notifications-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: TextTheme.of(context).titleMedium),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Dismissible(
          key: Key(index.toString()),
          onDismissed: (direction) => () {},
          child: ListTile(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            tileColor: Colors.white,
            subtitle: Text(
              "Your preview access to ‘Deep Work’ ends in 24 hours.",
            ),
            trailing: Text("1h ago"),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.notifications, color: Colors.orange),
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 5),
        itemCount: 10,
      ),
    );
  }
}
