import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({super.key});

  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _images = [];

  Future<void> pickImages() async {
    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage();
      List<Map<String, dynamic>> imagesData = [];
      for (var image in selectedImages) {
        File file = File(image.path);
        Uint8List imageBytes = await file.readAsBytes();
        int sizeInBytes = imageBytes.length;
        double sizeInKB = sizeInBytes / 1024;

        imagesData.add({
          "bytes": imageBytes,
          "size": sizeInKB.toStringAsFixed(2), // Size in KB
        });
      }
      setState(() {
        _images = imagesData;
      });
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Images'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: pickImages,
            child: const Text('Select Images'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.memory(
                      _images[index]['bytes'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text("Image ${index + 1}"),
                    subtitle: Text("Size: ${_images[index]['size']} KB"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
