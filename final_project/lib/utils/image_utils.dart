import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
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
    );
  }

  static Uint8List getDataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String toBase64String(Uint8List data) {
    return base64Encode(data);
  }

  static String logoAsBase64String() {
    var logoFile = File('assets/images/grape_vine.png').readAsBytesSync();
    return toBase64String(logoFile);
  }
}
