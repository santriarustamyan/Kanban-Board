import 'dart:convert';
import 'package:kanban_boards/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class UserRepository {
  Future<void> login(String usernameOrEmail, String password) async {
    final preferences = await SharedPreferences.getInstance();

    final Dio _dio = Dio();
    Response response;
    User? retrievedUser;
    _dio.options.headers['content-Type'] = 'application/json';
    try {
      response = await _dio.post(
        'https://trello.backend.tests.nekidaem.ru/api/v1/users/login/',
        data: jsonEncode(<String, dynamic?>{
          "username": usernameOrEmail,
          "password": password,
        }),
      );

      retrievedUser = User.fromJson(response.data);

      preferences.setString("token", "${retrievedUser.token}");
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
