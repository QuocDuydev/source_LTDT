import 'package:flutter/material.dart';
import 'package:thuc_hanh/repositores/forgot_repository.dart';

class ForgotViewModel with ChangeNotifier {
  final forgotRepo = ForgotRepository();
  String errormessege = "";
  int status = 0; // 0 chua gui, 1 dang gui, 2 loi, 3 thanh cong
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errormessege = "";
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_~`{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessege += "Email không hợp lệ!\n";
    }
    if (status != 2) {
      if (await forgotRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errormessege = "Không tồn tại email trên!";
      }
    }
    notifyListeners();
  }
}
