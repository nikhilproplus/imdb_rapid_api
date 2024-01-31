import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:imdb_rapid_api/controller/controller.dart';
import 'package:imdb_rapid_api/model/model.dart';

final GetDataController getDataController = Get.put(GetDataController());


class DataService {
  String apiUrl =
      'https://imdb146.p.rapidapi.com/v1/find/?query=${getDataController.itemName}';

  Future<WelcomeSuccess> getFilmData() async {
    debugPrint(apiUrl);
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'X-RapidAPI-Key': '6b33c0d435msh83caf79e8b731bbp15959djsn26626e4302fa',
        'X-RapidAPI-Host': 'imdb146.p.rapidapi.com',
      });

      debugPrint(response.body);

      if (response.statusCode == 200) {
        debugPrint('200 success');
        return welcomeSuccessFromJson(response.body);
      } else {
        throw Exception('Failed to post exception');
      }
    } catch (e) {
      throw Exception('Failed to get data in service $e');
    }
  }
}
