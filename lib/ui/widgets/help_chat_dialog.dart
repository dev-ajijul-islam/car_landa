import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:easy_localization/easy_localization.dart';

void openChatDialog({required BuildContext context}) {
  showDialog(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Align(
            alignment: const Alignment(-0.6, 0.2),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              height: 400,
              child: ClipPath(
                clipper: LowerNipMessageClipper(MessageType.send),
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF151B27),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                Image.asset(AssetsFilePaths.helpImg),
                                Text(
                                  "home.help_support".tr(),
                                  style: TextTheme.of(context).titleMedium
                                      ?.copyWith(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.do_not_disturb_on_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListView(
                                  children: List.generate(
                                    10,
                                        (index) => ClipPath(
                                      clipper: LowerNipMessageClipper(
                                        (index % 2 == 0)
                                            ? MessageType.send
                                            : MessageType.receive,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        color: (index % 2 == 0)
                                            ? ColorScheme.of(context).primary
                                            : Colors.red.withAlpha(100),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Multiple Points Clipper Bottom Only',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "chat_dialog.ask_question".tr(),
                                      suffixIcon: IconButton(
                                        color: ColorScheme.of(context).primary,
                                        onPressed: () {},
                                        icon: const Icon(Icons.telegram_outlined),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}