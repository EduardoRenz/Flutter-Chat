import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];
  List<ChatNotification> get items => [..._items];

  int get count => _items.length;

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Push Notifications

  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized == false) return;

    FirebaseMessaging.onMessage.listen(_messageHandler);
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized == false) return;

    FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized == false) return;
    RemoteMessage? initialMsg =
        await FirebaseMessaging.instance.getInitialMessage();
    _messageHandler(initialMsg);
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;
    add(ChatNotification(
      title: msg.notification!.title ?? 'Default Message',
      body: msg.notification!.body ?? 'Body not exists',
    ));
  }
}
