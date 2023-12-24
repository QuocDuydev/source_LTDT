import 'dart:convert';

import 'package:thuc_hanh/models/lop.dart';
import 'package:thuc_hanh/services/api_service.dart';

class LopRepository {
  Future<List<Lop>> getDsLop() async {
    List<Lop> list = [];
    list.add(Lop(ten: "--chọn--"));
    final response = await ApiService().getDsLop();
    if (response != null) {
      var data = response.data['data'];
      for (var item in data) {
        var lop = Lop.fromJson(item);
        list.add(lop);
      }
    }
    return list;
  }

  Future<List<Dssv>> getDssv(int id) async {
    final ApiService api = ApiService();
    List<Dssv> list = [];
    var response = await api.getDssv(id);
    if (response != null && response.data != null) {
      var data = response.data;
      List<dynamic> jsonList = json.decode(data);
      list = jsonList.map((json) => Dssv.fromJson(json)).toList();

      return list;
    }
    return [];
  }
}
