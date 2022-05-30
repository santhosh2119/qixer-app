import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicketService with ChangeNotifier {
  var pickedImage;
  final ImagePicker _picker = ImagePicker();
  Future pickImage(BuildContext context) async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }
}
