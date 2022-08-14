import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthMockService();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Chat Page'),
          TextButton(
            onPressed: () => authService.logout(),
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
