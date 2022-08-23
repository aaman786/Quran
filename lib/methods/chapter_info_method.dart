import 'dart:convert';

import 'package:http/http.dart';

class SurahInfoDetails {
  Map<String, dynamic> surahDescription = {};

  Future<Map<String, dynamic>> getSurahInfo(int surahNo) async {
    var url = Uri.parse(
        "https://api.quran.com/api/v4/chapters/$surahNo/info?language=en");
    var response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      surahDescription = jsonResponse["chapter_info"];
      return surahDescription;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return surahDescription;
  }
}
