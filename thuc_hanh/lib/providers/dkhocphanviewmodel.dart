import 'package:flutter/foundation.dart';
import 'package:thuc_hanh/models/hocphan.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/repositores/dkHP_repository.dart';

class DangKyHocPhanViewModel with ChangeNotifier {
  String message = '';
  int status = 0;
  DangKyHocPhanRepository hocphandangky = DangKyHocPhanRepository();
  Future<void> DangKyHocPhan(int id) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await hocphandangky.DangKyHocPhan(id);
      if (profile == 2) {
        status = 2;
        message = 'Đăng ký thành công';
      } else {
        message = "Đăng ký  thất bại !";
        status = 1;
      }

      notifyListeners();
    } catch (e) {
      status = 1;
      // ignore: avoid_print
      print(e);
    }
  }

  Future<List<HocPhanDangKy>> getHocPhanDangKy() async {
    notifyListeners();
    try {
      var profile = await hocphandangky.getHocPhanDangKy();
      List<HocPhanDangKy> allCourses = profile;
      final filteredList = allCourses
          .where((hocPhan) => hocPhan.idsinhvien == Profile().user.id)
          .toList();
      return filteredList;
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return [];
    }
  }
}
