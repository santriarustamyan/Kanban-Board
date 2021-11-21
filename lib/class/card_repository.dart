import 'dart:convert';
import 'package:kanban_boards/model/card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class CardRepository {
  Future<List<CardModel>> getCard() async {
    final preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token");
    final Dio _dio = Dio();
    late List<CardModel> card = [];
    Response response;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = "JWT $token";
    _dio.options.headers['charset'] = 'utf-8';

    try {
      response = await _dio
          .get('https://trello.backend.tests.nekidaem.ru/api/v1/cards/');
      var parsed = jsonDecode(jsonEncode(response.data));
      card = parsed.map<CardModel>((json) => CardModel.fromJson(json)).toList();
    } catch (e) {
      print('Error creating user: $e');
    }
    return card;
  }
}
