import 'package:dio/dio.dart';

import '../../shared/resources/resource.dart';
import '../api_client.dart';

class AuthRepository {
  Future<Response> login(
      String username, String password) async {
    Map<String, dynamic> param = {
      'username': username,
      'password': password,
    };
    var response = await ApiClient.instance
        .post(apiLogin, param);
    return response;
  }

  Future<Response> forgotPassword(String email) async {
    final param = {'email': email};
    return await ApiClient.instance.get(apiForgotPassword, param: param);
  }

  Future<Response> logOut(int idDeviceToken) async {
    Map<String, dynamic> param = {
      'idDeviceToken': idDeviceToken,
    };
    var response = await ApiClient.instance
        .post(apiLogout, param);
    return response;
  }

  Future<Response> register({
    required String email,
    required String name,
    required String username,
    required String password,
    String? selectedImage
  }) async {
    FormData formData = selectedImage != null
        ? FormData.fromMap({
      'email': email,
      'name': name,
      'username': username,
      'password': password,
      'file': await MultipartFile.fromFile(
        selectedImage,
        filename: 'image.jpg',
      )
    })
        : FormData.fromMap({
      'email': email,
      'name': name,
      'username': username,
      'password': password
    });
    var response = await ApiClient.instance.post(
        selectedImage != null ? apiRegisterWithFile : apiRegister, formData);
    return response;
  }
}