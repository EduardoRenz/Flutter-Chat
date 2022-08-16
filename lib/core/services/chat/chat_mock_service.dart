import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
        id: '1',
        text: 'This is an example of message',
        createdAt: DateTime.now(),
        userId: '123',
        userName: 'Chat Bot',
        userImageURL: 'assets/images/avatar.png'),
    ChatMessage(
        id: '2',
        text: 'This is an example of response',
        createdAt: DateTime.now(),
        userId: '1234',
        userName: 'Chat Bot 2',
        userImageURL: 'assets/images/avatar.png')
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final Stream<List<ChatMessage>> _messageStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _messageStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final message = ChatMessage(
      id: '${_messages.length}${Random().nextDouble()}',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );
    _messages.add(message);
    _controller?.add(_messages.reversed.toList());
    return message;
  }
}
