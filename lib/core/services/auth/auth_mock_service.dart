import 'package:chat/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  @override
  // TODO: implement currentUser
  ChatUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
      String name, String email, String password, File image) async {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement userChanges
  Stream<ChatUser> get userChanges => throw UnimplementedError();
}
