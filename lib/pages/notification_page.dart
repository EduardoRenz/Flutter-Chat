import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
      ),
      body: ListView.builder(
        itemCount: service.count,
        itemBuilder: (context, i) {
          final item = items[i];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.body),
            onTap: () => service.remove(i),
          );
        },
      ),
    );
  }
}
