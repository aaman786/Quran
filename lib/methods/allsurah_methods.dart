import 'dart:convert';
import 'package:http/http.dart';
import '../models/chapter_model.dart';
import 'general_methods.dart';

class AllSurah {
  List<Chapter> allChapters = [];

  Map<String, dynamic> individualSurahInfo = <String, dynamic>{};

  General general = General();

  Future<List<Chapter>> getData() async {
    try {
      final urlChaptersList =
          Uri.parse("https://api.quran.com/api/v4/chapters");
      final response = await get(urlChaptersList);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> body = jsonResponse['chapters'];

        allChapters = body.map((e) => Chapter.fromJson(e)).toList();
        return allChapters;
      } else {
        print("The status code is: ${response.statusCode}");
      }
    } catch (e) {
      print("The error is: " + e.toString());
    }
    return allChapters;
  }

  String? _juzNoEn;
  String? _juzNoAr;
  String? _juzNameEn;
  String? _juzNameAr;

  String get juzNoEn {
    return _juzNoEn!;
  }

  String get juzNoAr {
    return _juzNoAr!;
  }

  String get juzNameEn {
    return _juzNameEn!;
  }

  String get juzNameAr {
    return _juzNameAr!;
  }

  String? getJuz(int surahId) {
    Map<String, dynamic> juzMap = general.giveJuzNameAndNumber(surahId);

    String juzNoList = juzMap['juz_no'].toString();
    _juzNoEn = juzNoList.substring(1, juzNoList.length - 1);
    _juzNoAr = general.replaceFarsiNumber(juzNoEn);

    String juzNameListEn = juzMap['juz_name_en'].toString();
    _juzNameEn = juzNameListEn.substring(1, juzNameListEn.length - 1);

    String juzNameListAr = juzMap['juz_name_ar'].toString();
    _juzNameAr = juzNameListAr.substring(1, juzNameListAr.length - 1);

    return juzNoEn;
  }
}
