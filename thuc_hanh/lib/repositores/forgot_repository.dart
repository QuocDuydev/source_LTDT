import '../services/api_service.dart';

class ForgotRepository {
  final ApiService api = ApiService();
  Future<bool> forgotPassword(String email) async {
    final response = await api.forgotPassword(email);
    if (response != null && response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
