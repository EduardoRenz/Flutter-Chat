import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthFormData _formData = AuthFormData();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          duration: const Duration(seconds: 5),
          backgroundColor: Theme.of(context).errorColor),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_formData.image == null && _formData.isSignUp) {
      return _showError('Please pick an image.');
    }

    widget.onSubmit(_formData);
  }

  void _handleImagePick(File file) {
    _formData.image = file;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignUp)
                  UserImagePicker(onImagePick: _handleImagePick),
                if (_formData.isSignUp)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.isEmpty || name.trim().length < 3) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.isEmpty || !email.contains('@')) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 6) {
                      return 'Password is required and must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text(_formData.isLogin ? 'Enter' : 'Sign Up'),
                  onPressed: _submit,
                ),
                const SizedBox(height: 12),
                TextButton(
                  child: Text(_formData.isLogin ? 'Register' : 'Login'),
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }
}
