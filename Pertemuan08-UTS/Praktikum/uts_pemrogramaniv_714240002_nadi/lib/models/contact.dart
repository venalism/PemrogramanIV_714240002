import 'dart:typed_data';

import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final DateTime date;
  final Color color;
  final String fileName;
  final Uint8List? fileBytes;

  const Contact({
    required this.name,
    required this.phone,
    required this.date,
    required this.color,
    required this.fileName,
    this.fileBytes,
  });

  bool get isImage {
    final ext = fileName.split('.').last.toLowerCase();
    return ext == 'jpg' || ext == 'jpeg' || ext == 'png';
  }
}
