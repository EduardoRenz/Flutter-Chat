import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = ChatUser(
    id: '1234',
    name: 'John Doe',
    email: 'john@gmail.com',
    imageUrl: 'assets/images/avatar.png',
  );

  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    //  setCurrentUser(_defaultUser);
    setCurrentUser(null);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    final user = _users[email];
    setCurrentUser(user);
  }

  @override
  Future<void> logout() async {
    setCurrentUser(null);
  }

  @override
  Future<void> signUp(
      String name, String email, String password, File? image) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => newUser);
    setCurrentUser(newUser);
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static void setCurrentUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
