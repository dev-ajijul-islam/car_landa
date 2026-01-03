import 'package:car_hub/data/model/user_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/home/notifications_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AuthProvider>().dbUser;
    return   Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: SvgPicture.asset(
              AssetsFilePaths.svgTriangle,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        if (user != null) ...[
          Visibility(
            visible:
            context.watch<AuthProvider>().dbUser != null,
            child: Positioned(
              top: 40,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: user.photo != null
                                ? NetworkImage(
                              user.phone.toString(),
                            )
                                : AssetImage(
                              AssetsFilePaths.dummyProfile,
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, ${user.name}",
                                style: TextTheme.of(context)
                                    .titleMedium
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 17,
                                  height: 0,
                                ),
                              ),
                              Text(
                                "Welcome back!",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ColorScheme.of(
                            context,
                          ).primary,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            NotificationsScreen.name,
                          );
                        },
                        icon: Icon(Icons.notifications_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        Positioned(
          top: 90,
          right: 15,
          child: Image.asset(width: 240, AssetsFilePaths.car2),
        ),
      ],
    );
  }
}
