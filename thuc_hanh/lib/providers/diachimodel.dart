import 'package:thuc_hanh/models/place.dart';
import 'package:thuc_hanh/repositores/place_repository.dart';
import 'package:flutter/foundation.dart';

class DiaChiModel with ChangeNotifier {
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];
  int curCityId = 0;
  int curDisId = 0;
  int curWardId = 0;
  String address = "";
  Future<void> initialize(int Cid, int Did, int Wid) async {
    curCityId = Cid;
    curDisId = Did;
    curWardId = Wid;
    final repo = PlaceRepository();
    listCity = await repo.getListCity();
    // listDistrict = await repo.getListDistrict(curDistrictId);
    // listWard = await repo.getListWard(curWardId);
    if (curCityId != 0) {
      listDistrict = await repo.getListDistrict(curCityId);
    }
    if (curDisId != 0) {
      listWard = await repo.getListWard(curDisId);
    }
  }

  Future<void> setCity(int Cid) async {
    if (Cid != curCityId) {
      curCityId = Cid;
      curDisId = 0;
      curWardId = 0;
      final repo = PlaceRepository();
      listDistrict = await repo.getListDistrict(curCityId);
      listWard.clear();
    }
  }

  Future<void> setDistrict(int Did) async {
    if (Did != curDisId) {
      curDisId = Did;
      curWardId = 0;
      final repo = PlaceRepository();
      listWard = await repo.getListWard(curDisId);
    }
  }

  Future<void> setWard(int Wid) async {
    if (Wid != curWardId) {
      curWardId = Wid;
    }
  }
}
