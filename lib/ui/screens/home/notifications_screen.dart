import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/providers/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  static String name = "notifications-screen";

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<NotificationsProvider>().getNotifications(
          userId: AuthProvider().dbUser!.id.toString(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "notifications.title".tr(),
          style: TextTheme.of(context).titleMedium,
        ),
      ),
      body: Consumer<NotificationsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.notifications.isEmpty) {
            return Center(child: Text("Notification not found"));
          }
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              tileColor: Colors.white,
              subtitle: Text("notifications.sample_message".tr()),
              trailing: Text("notifications.time_ago".tr()),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.notifications, color: Colors.orange),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: provider.notifications.length,
          );
        },
      ),
    );
  }
}
