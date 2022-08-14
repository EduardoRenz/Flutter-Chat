import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File file) onImagePick;
  const UserImagePicker({Key? key, required this.onImagePick})
      : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.image),
          label: const Text('Pick an image'),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
