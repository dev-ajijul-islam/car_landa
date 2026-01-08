  import 'package:car_hub/providers/auth_provider.dart';
  import 'package:car_hub/ui/screens/home/notifications_screen.dart';
  import 'package:car_hub/utils/assets_file_paths.dart';
  import 'package:easy_localization/easy_localization.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:provider/provider.dart';

  class HeroBanner extends StatelessWidget {
    const HeroBanner({super.key});

    @override
    Widget build(BuildContext context) {
      return Stack(
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

          Consumer<AuthProvider>(
            builder: (context, provider, child) {
              final user = provider.dbUser;
              return Visibility(
                visible: provider.dbUser != null,
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
                                backgroundImage: user?.photo != null
                                    ? NetworkImage(user!.photo.toString())
                                    : AssetImage(AssetsFilePaths.dummyProfile) as ImageProvider,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"hero_banner.hello".tr()}, ${user?.name}",
                                    style: TextTheme.of(context).titleMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 17,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    "hero_banner.welcome_back".tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: ColorScheme.of(context).primary,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                NotificationsScreen.name,
                              );
                            },
                            icon: const Icon(Icons.notifications_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 90,
            right: 15,
            child: Image.asset(width: 240, AssetsFilePaths.car2),
          ),
        ],
      );
    }
  }