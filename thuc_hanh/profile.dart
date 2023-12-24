import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuc_hanh/models/student.dart';
import 'package:thuc_hanh/models/user.dart';

void main() async {
  Profile profile = Profile();
  await profile
      .initalize(); // Gọi phương thức để khởi tạo và lấy dữ liệu từ SharedPreferences
  print('Token: ${profile.token}'); // In ra giá trị của token từ lớp Profile
}

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

  Future<void> clearToken() async {
    await _pref?.remove('token');
    // Cập nhật giá trị token trong lớp
    token = "";
  }

  // Phương thức để reset username và password về rỗng
  Future<void> resetUsernamePassword() async {
    await _pref?.remove('username');
    await _pref?.remove('password');
  }
}
