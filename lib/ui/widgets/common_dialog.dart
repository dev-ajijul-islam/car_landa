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
        insetPadding: EdgeInsets.all(20),
        content: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(AssetsFilePaths.doneSvg),
              ),
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
        ),
      );
    },
  );
}