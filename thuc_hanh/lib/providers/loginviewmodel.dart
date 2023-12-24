import 'package:flutter/material.dart';
import 'package:thuc_hanh/models/student.dart';
import 'package:thuc_hanh/models/user.dart';
import 'package:thuc_hanh/repositores/login_repository.dart';
import 'package:thuc_hanh/repositores/student_repository.dart';
import 'package:thuc_hanh/repositores/user_repository.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0; // 0 - not login, 1 - waiting, 2 - error, 3 - ready logged
  LoginRepository loginRepo = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Tên đăng nhập hoặc Mật khẩu không đúng!";
      } else {
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        status = 3;
      }
      notifyListeners();
    } catch (e) {}
  }
}
