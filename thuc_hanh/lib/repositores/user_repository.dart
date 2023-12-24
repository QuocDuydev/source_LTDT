import 'dart:io';

import 'package:thuc_hanh/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';
import 'package:image/image.dart' as img;

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getUserInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<void> uploadAvatar(XFile image) async {
    ApiService api = ApiService();
    // ignore: unnecessary_null_comparison
    if (image != null) {
      // Thay doi kich thuoc anh
      final img.Image originalImage =
          img.decodeImage(File(image.path).readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(originalImage, width: 180);
      // luu thanh file moi
      final File resizedFile =
          File(image.path.replaceAll('.jpg', '_resized.jpg'))
            ..writeAsBytesSync(img.encodeJpg(resizedImage));
      // Gui anh da thay doi kich thuoc len server thong qua API
      await api.uploadAvatarToServer(File(resizedFile.path));
    }
  }
}
