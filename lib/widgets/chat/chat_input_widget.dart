import 'package:flutter/material.dart';

import '../../core/palette.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    Key? key,
    // required this.messageController,
    required this.isLoading,
    required this.sendMessage,
  }) : super(key: key);

  // final TextEditingController messageController;
  final bool isLoading;
  final Function(String p1) sendMessage;

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: messageController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            hintText: 'Type a new message...',
            hintStyle: const TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              // borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          onChanged: (value) {
            setState(() {});
            print(
                '===== messageController.text.isEmpty: ${messageController.text.isEmpty}');
          },
        ),
        TextButton(
          onPressed: messageController.text.isEmpty
              ? null
              : () {
                  widget.sendMessage(messageController.text);
                  messageController.clear();
                },
          child: Text(
            'Send',
            style: TextStyle(
              color: messageController.text.isEmpty
                  ? Colors.grey
                  : Palette.kToDark,
              // color: Palette.kToDark,
            ),
          ),
        ),
      ],
    );
  }
}
