import 'package:car_hub/ui/screens/home/home_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void commonDialog(BuildContext context,{required String title,required String subtitle }) {
  Future.delayed(Duration(seconds: 1), () async {
    Navigator.pop(context);
  });

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(50),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            SvgPicture.asset(AssetsFilePaths.doneSvg),
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextTheme.of(context).titleLarge,
            ),
            Text(
              textAlign: TextAlign.center,
              subtitle,
            ),
          ],
        ),
      );
    },
  );
}
