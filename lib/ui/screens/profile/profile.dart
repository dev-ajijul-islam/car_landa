import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/ui/screens/profile/change_password.dart';
import 'package:car_hub/ui/screens/profile/my_history.dart';
import 'package:car_hub/ui/screens/profile/personal_information.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                    backgroundImage: NetworkImage(
                      "https://scontent.fdac24-5.fna.fbcdn.net/v/t39.30808-1/455086251_1029469555479420_7495595057560540792_n.jpg?stp=c0.411.1365.1364a_dst-jpg_s480x480_tt6&_nc_cat=105&ccb=1-7&_nc_sid=1d2534&_nc_eui2=AeHG59vjK7oCVF247ccDGzMkfI0X5DlYQtB8jRfkOVhC0H31wd3jNO6Z2zvdgc1g92xM_OuDQXBb5ScSne_0qs9R&_nc_ohc=_u9iSgq4-TEQ7kNvwFS4qsP&_nc_oc=AdnCpeXKetzlzB4vsJ4yiBDfs0l6F89WlDxilWeY8GwA-xqRhBm-0tR1EoTAIK5GuWw&_nc_zt=24&_nc_ht=scontent.fdac24-5.fna&_nc_gid=bgzSj--_j13pz1yOWe3OjA&oh=00_Afk8fJXUZWEOmLIdsKI86afTO8YhP2EVxVW0XtROLTIiGw&oe=693DD180",
                    ),
                  ),
                  Positioned(
                    bottom: -17,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircleAvatar(radius: 16, child: Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                Text("Ajijul Islam", style: TextTheme.of(context).titleMedium),
                Text("devajijulislam@gmail.com"),
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
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: profileTiles.length,
            ),
          ],
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
    {"icon": Icons.directions_car_sharp, "title": "My Bookings Car"},
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
    {"icon": Icons.question_mark, "title": "Terms & Condition"},
    {"icon": Icons.logout_outlined, "title": "Log Out"},
  ];
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
          Navigator.pushNamed(context, widget.route!,arguments: {"fromProfileScreen" : true});
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
}
