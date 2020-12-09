import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static final _picker = ImagePicker();

  static get picker {
    return _picker;
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
      width: 300,
      height: 300,
    );
  }

  static Uint8List getDataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String toBase64String(Uint8List data) {
    return base64Encode(data);
  }

  static Future<String> logoAsBase64String() async {
    String logoData;
    await rootBundle.load('assets/images/grape_vine.png').then((result) {
      logoData = toBase64String(result.buffer.asUint8List());
    });

    return logoData;
  }
}
