// gallery.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  final Function(XFile?) onImagePicked;

  const Gallery({super.key, required this.onImagePicked});

  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image; // 선택된 이미지 파일

  // 앱 시작 시 자동으로 갤러리에서 이미지 선택
  @override
  void initState() {
    super.initState();
    // 자동으로 갤러리 열기
    _pickImage();
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택

    setState(() {
      _image = image; // 선택된 이미지 저장
    });

    // 이미지가 선택되면 콜백 함수 호출 (FeedUpload 컴포넌트로 전달)
    widget.onImagePicked(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
