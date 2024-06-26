import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';


class Utils{
  Future<Uint8List?> pickImage() async{
    ImagePicker picker=ImagePicker();
    XFile? file=await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }
}