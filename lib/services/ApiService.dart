import 'package:eezi_connect/helpers/api_provider.dart';
import 'package:eezi_connect/models/User.dart';
import 'package:get/get.dart';

class ApiService {
  // final baseUrl = 'http://54.169.252.1:90/api/v1/auth';
  final baseUrl = 'http://10.0.2.2:8000/api/v1/auth';
  final ApiProvider apiProvider = Get.put(ApiProvider());

  Future<User> verificationToken({
    String userId,
    String token,
  }) async {
    final response = await apiProvider.post('/verification-token/', {
      'user_id': userId,
      'token': token,
    });

    print(response);
    final user = userFromJson(response);
    return user;
  }

  Future<User> registerPhoneNumber({String phoneNumber}) async {
    print('/register-by-phone-number/');
    final response = await apiProvider.post('/register-by-phone-number/', {
      'phone_number': phoneNumber,
    });
    print(response);
    final user = userFromJson(response);
    return user;
  }

  Future<User> updateUserData(
      {String username,
      String fullName,
      String phoneNumber,
      String email,
      String address,
      String avatar,
      String user_id}) async {
    final response = await apiProvider.post('/update-user-data/', {
      'user_id': user_id,
      'username': username,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'address': address,
      'avatar': avatar
    });

    print(response);
    final user = userFromJson(response);
    return user;
  }
}
