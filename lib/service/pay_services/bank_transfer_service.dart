import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BankTransferService with ChangeNotifier {
  var images;
  final ImagePicker _picker = ImagePicker();
  Future pickImage(BuildContext context) async {
    images = await _picker.pickMultiImage();

    notifyListeners();
  }
}
