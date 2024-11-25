import 'dart:html' as html;
import 'dart:typed_data';

//# This model for storing multiple images
class FormImageModel {
  int? id;
  String? name;
  html.File? file;
  Uint8List? bytes;

  FormImageModel({
    this.id,
    this.name,
    this.file,
    this.bytes,
  });
}
