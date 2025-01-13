import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerManager {
  File? imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
