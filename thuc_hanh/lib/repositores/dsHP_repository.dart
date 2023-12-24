import 'package:thuc_hanh/models/hocphan.dart';
import 'package:thuc_hanh/services/api_service.dart';

class DSHocPhanRepository {
  final ApiService api = ApiService();
  Future<List<HocPhan>> getDsHocPhan() async {
    List<HocPhan> list = [];
    var response = await api.getDsHocPhan();
    if (response != null && response.statusCode == 200) {
      var data = response.data['data'];
      for (var item in data) {
        var hocphan = HocPhan.fromJson(item);
        list.add(hocphan);
      }
    }
    return list;
  }
}
