import 'package:flutter/material.dart';
import 'package:thuc_hanh/repositores/register_repository.dart';

class RegisterViewModel with ChangeNotifier {
  int status =
      0; // 0 - chua dang ky, 1- dang dang ky, 2 - đk loi, 3- dk can xac minh email, 4 - đk ko xac minh email
  String errormessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh =
      // ignore: prefer_interpolation_to_compose_strings
      "Khi tham gia vào ứng dụng các bạn đồng lý các điều khoản sau:\n" +
          "1. Các thông tin của bạn sẽ được chia sẻ với các thành viên\n" +
          "2. Thông tin của bạn có thể ảnh hưởng học tập ở trường\n" +
          "3. Thông tin của bạn sẽ được xóa vĩnh viễn khi có yêu cầu xóa thông tin";

  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
      String email, String username, String pass1, String pass2) async {
    status = 1;
    notifyListeners();

    errormessage = "";
    if (agree == false) {
      status = 2;
      errormessage += "Bạn phải đồng ý điều khoản trước khi đăng ký\n";
    }
    if (email.isEmpty || username.isEmpty || pass1.isEmpty) {
      status = 2;
      errormessage = "Email, Usermane, Password không được để trống\n";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_~`{|}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Email không hợp lệ!\n";
    }
    if (pass1.length < 8) {
      status = 2;
      errormessage += "Password cần lớn hơn 8 ký tự!\n";
    }
    if (pass1 != pass2) {
      status = 2;
      errormessage = "Mật khẩu không giống nhau!";
    }
    if (status != 2) {
      status = await registerRepo.register(email, username, pass1);
    }

    // sử dụng repository gọi hàm login và lấy kết quả

    notifyListeners();
  }
}
