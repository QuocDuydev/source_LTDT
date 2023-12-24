import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/models/user.dart';
import 'package:thuc_hanh/repositores/user_repository.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;
  int modified = 0;
  int updateavatar = 0;

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateavatar = 0;
    status = 0;
    notifyListeners();
  }

  void setUpdateAvatar() {
    updateavatar = 1;
    notifyListeners();
  }

  void updateScreen() {
    status = 0;
    notifyListeners();
  }

  void displaySpinner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;

      notifyListeners();
    }
  }

  void hideSpinner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }
}
