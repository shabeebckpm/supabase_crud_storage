import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile; // For Android/iOS
  Uint8List? _webImageBytes; // For Web

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        if (kIsWeb) {
          final Uint8List bytes = await image.readAsBytes();
          setState(() {
            _webImageBytes = bytes;
          });
        } else {
          setState(() {
            _imageFile = File(image.path);
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
  //upload function

Future<void> uploadImage() async {
  if (_webImageBytes == null && _imageFile == null) return;

  try {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';

    if (kIsWeb) {
      // For web, use Uint8List (raw bytes)
      await Supabase.instance.client.storage
          .from('images')
          .uploadBinary(
            path,
            _webImageBytes!,
          )
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Image uploaded successfully')),
              ));
    } else {
      // For non-web, use File from dart:io
      final file = File(_imageFile!.path);
      await Supabase.instance.client.storage
          .from('images')
          .upload(
            path,
            file,
          )
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Image uploaded successfully')),
              ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error uploading image: $e')),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_imageFile != null || (kIsWeb && _webImageBytes != null))
              kIsWeb
                  ? Image.memory(_webImageBytes!)
                  : Image.file(_imageFile!)
            else
              const Text('No Image Selected'),
           
           //upload button
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
