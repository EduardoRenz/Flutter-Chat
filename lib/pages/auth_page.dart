import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;
  final AuthService _authService = AuthMockService();

  void _handleSubmit(AuthFormData data) async {
    try {
      setState(() => _isLoading = true);

      if (data.isLogin) {
        await _authService.login(data.email, data.password);
      } else {
        await _authService.signUp(
            data.name, data.email, data.password, data.image);
      }
    } catch (e) {
      //TODO: Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
              child: SingleChildScrollView(
            child: AuthForm(_handleSubmit),
          )),
          if (_isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }
}
