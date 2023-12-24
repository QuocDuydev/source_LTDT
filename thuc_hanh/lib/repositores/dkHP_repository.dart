import 'package:thuc_hanh/models/hocphan.dart';
import 'package:thuc_hanh/services/api_service.dart';

class DangKyHocPhanRepository {
  final ApiService api = ApiService();
  int kq = 1;
  Future<int> DangKyHocPhan(int id) async {
    var response = await api.DangKyHocPhan(id);
    if (response != null && response.statusCode == 200) {
      kq = 2;
    } else {
      kq = 3;
    }
    return kq;
  }

  Future<List<HocPhanDangKy>> getHocPhanDangKy() async {
    List<HocPhanDangKy> hocphandangky = [];
    var response = await api.getHocPhanDangKy();
    if (response != null && response.statusCode == 200) {
      var data = response.data['data'];
      for (var item in data) {
        var json = HocPhanDangKy.fromJson(item);
        hocphandangky.add(json);
      }
    }
    return hocphandangky;
  }
}
