import 'dart:io';

import 'package:car_hub/data/model/user_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/ui/screens/profile/change_password.dart';
import 'package:car_hub/ui/screens/profile/my_bookings.dart';
import 'package:car_hub/ui/screens/profile/my_history.dart';
import 'package:car_hub/ui/screens/profile/personal_information.dart';
import 'package:car_hub/ui/screens/profile/terms_and_condition.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.read<AuthProvider>().dbUser;
    return Scaffold(
      body: SafeArea(
        child: Visibility(
          visible: context.read<AuthProvider>().dbUser != null,
          replacement: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.name);
              },
              child: Text("Login"),
            ),
          ),
          child: user != null
              ? ListView(
                  children: [
                    SizedBox(height: 30),
                    Align(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            backgroundImage: profileImage != null
                                ? FileImage(File(profileImage!.path))
                                : user.photo != null
                                ? NetworkImage(user.photo.toString())
                                : AssetImage(AssetsFilePaths.dummyProfile),
                          ),

                          Positioned(
                            bottom: -17,
                            child: GestureDetector(
                              onTap: _onTapProfilePicture,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircleAvatar(
                                  radius: 16,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Text(
                          user.name.toString(),
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(user.email.toString()),
                      ],
                    ),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        final item = profileTiles[index];
                        return ProfileMenuTile(
                          title: item["title"],
                          icon: item["icon"],
                          switchMode: item["title"] == "Notification",
                          route: item["route"],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: profileTiles.length,
                    ),
                  ],
                )
              : SizedBox(),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> profileTiles = [
    {
      "icon": Icons.person_2_outlined,
      "title": "Personal Information",
      "route": PersonalInformation.name,
    },
    {
      "icon": Icons.lock_outline_rounded,
      "title": "Change Password",
      "route": ChangePassword.name,
    },
    {"icon": Icons.notifications_outlined, "title": "Notification"},
    {
      "icon": Icons.directions_car_sharp,
      "title": "My Bookings Car",
      "route": MyBookings.name,
    },
    {
      "icon": Icons.history_outlined,
      "title": "History",
      "route": MyHistory.name,
    },
    {
      "icon": Icons.language_outlined,
      "title": "Language",
      "route": LanguageSelectScreen.name,
    },
    {
      "icon": Icons.question_mark,
      "title": "Terms & Condition",
      "route": TermsAndCondition.name,
    },
    {"icon": Icons.logout_outlined, "title": "Log Out"},
  ];

  Future _onTapProfilePicture() async {
    ImagePicker picker = ImagePicker();
    XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = picked;
    });
  }
}

class ProfileMenuTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool? switchMode;
  final String? route;

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.icon,
    this.switchMode,
    this.route,
  });

  @override
  State<ProfileMenuTile> createState() => _ProfileMenuTileState();
}

class _ProfileMenuTileState extends State<ProfileMenuTile> {
  bool isNotificationOn = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.route != null) {
          Navigator.pushNamed(
            context,
            widget.route!,
            arguments: {"fromProfileScreen": true},
          );
        } else if (widget.title == "Log Out") {
          _onTapLogOut();
        }
      },
      leading: Icon(widget.icon),
      trailing: (widget.switchMode == true && widget.switchMode != null)
          ? Switch(
              value: isNotificationOn,
              onChanged: (value) {
                setState(() {
                  isNotificationOn = value;
                });
              },
            )
          : Icon(Icons.chevron_right_outlined),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      tileColor: Colors.white,
      title: Text(widget.title),
    );
  }

  void _onTapLogOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsFilePaths.done),
            Text("Log Out?", style: TextTheme.of(context).titleMedium),
            Text(
              textAlign: TextAlign.center,
              "You’ve been signed out safely. See you again soon!",
              style: TextTheme.of(context).bodyMedium,
            ),
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(onPressed: () {}, child: Text("No")),
                ),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 40),
                    ),
                    onPressed: () {
                      context.read<AuthProvider>().signOut(context);
                    },
                    child: Text("Yes"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}
