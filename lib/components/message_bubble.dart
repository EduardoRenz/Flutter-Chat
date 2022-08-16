import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: belongsToCurrentUser
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Text(
                message.userName,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                    ),
              ),
              Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
