import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);
    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(imageURL);
    } else if (uri.scheme == 'http' || uri.scheme == 'https') {
      provider = NetworkImage(imageURL);
    } else {
      provider = FileImage(File(imageURL));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = Radius.circular(12);
    final bubbleSize = MediaQuery.of(context).size.width * 0.5;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: !belongsToCurrentUser
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              padding: const EdgeInsets.all(10),
              width: bubbleSize,
              decoration: BoxDecoration(
                  color: !belongsToCurrentUser
                      ? Colors.grey[300]
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: borderRadius,
                    topRight: borderRadius,
                    bottomLeft: !belongsToCurrentUser
                        ? const Radius.circular(0)
                        : borderRadius,
                    bottomRight: belongsToCurrentUser
                        ? const Radius.circular(0)
                        : borderRadius,
                  )),
              child: Column(
                crossAxisAlignment: !belongsToCurrentUser
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    message.userName,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: !belongsToCurrentUser
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: !belongsToCurrentUser
                              ? Colors.black
                              : Colors.white,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: -5,
          left: bubbleSize - 20,
          child: _showUserImage(message.userImageURL),
        )
      ],
    );
  }
}
