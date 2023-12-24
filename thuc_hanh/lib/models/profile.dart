import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuc_hanh/models/student.dart';
import 'package:thuc_hanh/models/user.dart';

class Profile {
  static final Profile _instance = Profile._internal();
  Profile._internal({this.token = ""});
  factory Profile() {
    return _instance;
  }

  SharedPreferences? _pref;
  late String token;
  Student student = Student();
  User user = User();
  Future<void> initalize() async {
    _pref = await SharedPreferences.getInstance();
    token = "";
  }

  Future<void> setUsernamePassword(String username, String password) async {
    _pref?.setString("username", username);
    _pref?.setString("password", password);
  }

  String get username => _pref?.getString('username') ?? '';
  String get password => _pref?.getString('password') ?? '';

  void onLogout() async {
    Profile profile = Profile();
    await profile.clearToken();
    await profile
        .resetUsernamePassword(); // Gọi phương thức clearToken để xóa token
    profile
        .initalize(); // Gọi lại initalize() để cập nhật SharedPreferences và token
  }

  Future<void> clearToken() async {
    await _pref?.remove('token');
    // Xóa giá trị token trong lớp Profile
  }

  // Phương thức để reset username và password về rỗng
  Future<void> resetUsernamePassword() async {
    await _pref?.remove('username');
    await _pref?.remove('password');
  }
}
