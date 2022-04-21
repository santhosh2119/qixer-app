import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditService with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      return imageFile;
    } else {
      return null;
    }
  }
}
