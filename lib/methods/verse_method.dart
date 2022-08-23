import 'dart:convert';
import 'package:compass/models/verse_model.dart';
import 'package:http/http.dart';
import '../models/translation_model.dart';

class Verse {
  List<VerseArabic> _verses = [];
  List<VerseArabic> get verses {
    return _verses;
  }

  List<EngTranslation> _versesEng = [];
  List<EngTranslation> get versesEng {
    return _versesEng;
  }

  List<HinTranslation> _versesHin = [];
  List<HinTranslation> get versesHin {
    return _versesHin;
  }

  Future<List<VerseArabic>> getDataVerse(int chapNo) async {
    var url = Uri.parse(
        "https://api.quran.com/api/v4/quran/verses/uthmani?chapter_number=$chapNo");

    var response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse["verses"];

      _verses = body.map((e) => VerseArabic.fromJson(e)).toList();
      await getTransEng(chapNo);
      await getTransHin(chapNo);
      return verses;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return verses;
  }

  Future<void> getTransEng(int chapNo) async {
    var url = Uri.parse(
        "https://api.quran.com/api/v4/quran/translations/131?chapter_number=$chapNo");

    var response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse["translations"];

      _versesEng = body.map((e) => EngTranslation.fromJson(e)).toList();
      print(versesEng[0].toJson()["text"]);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> getTransHin(int chapNo) async {
    var url = Uri.parse(
        "https://api.quran.com/api/v4/quran/translations/122?chapter_number=$chapNo");

    var response = await get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> body = jsonResponse["translations"];

      _versesHin = body.map((e) => HinTranslation.fromJson(e)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
