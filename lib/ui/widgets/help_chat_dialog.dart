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
      return _LocalChatDialog();
    },
  );
}

class _LocalChatDialog extends StatefulWidget {
  @override
  State<_LocalChatDialog> createState() => _LocalChatDialogState();
}

class _LocalChatDialogState extends State<_LocalChatDialog> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _hasReplied = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));

      if (!_hasReplied) {
        _hasReplied = true;
        _messages.add(
          _ChatMessage(
            text:
            "Thanks for reaching out! Our support team will review your message and get back to you soon. 🙏",
            isUser: false,
          ),
        );
      }
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                style: TextTheme.of(context)
                                    .titleMedium
                                    ?.copyWith(
                                    color: Colors.white, fontSize: 18),
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
                                  _messages.length,
                                      (index) {
                                    final msg = _messages[index];
                                    return ClipPath(
                                      clipper: LowerNipMessageClipper(
                                        msg.isUser
                                            ? MessageType.send
                                            : MessageType.receive,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        color: msg.isUser
                                            ? ColorScheme.of(context).primary
                                            : Colors.red.withAlpha(100),
                                        alignment: Alignment.center,
                                        child: Text(
                                          msg.text,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText:
                                    "Ask me anything",
                                    suffixIcon: IconButton(
                                      color:
                                      ColorScheme.of(context).primary,
                                      onPressed: _sendMessage,
                                      icon: const Icon(
                                          Icons.telegram_outlined),
                                    ),
                                  ),
                                  onSubmitted: (_) => _sendMessage(),
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
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}
