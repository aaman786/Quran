import 'dart:convert';

import 'package:http/http.dart';

import 'methods/chapter_info_method.dart';

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

// Future<void> getData() async {
//   // Autogenerated autogenerated = Autogenerated();

//   List<Chapter> chapters = [];

//   var url = Uri.parse("https://api.quran.com/api/v4/chapters");
//   var response = await get(url);
//   if (response.statusCode == 200) {
//     final jsonResponse = jsonDecode(response.body);
//     List<dynamic> body = jsonResponse['chapters'];

//     chapters = body.map((e) => Chapter.fromJson(e)).toList();
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//   }

//   Map<String, dynamic> body1 = chapters[0].toJson()['translated_name'];
//   print(body1);
// }

Future<void> getDataInfo() async {
  var url =
      Uri.parse("https://api.quran.com/api/v4/chapters/1/info?language=en");
  var response = await get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    Map<String, dynamic> body = jsonResponse["chapter_info"];

    print(body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

main() async {
  print("aman");

  SurahInfoDetails surahInfoDetails = SurahInfoDetails();
  // await surahInfoDetails.getSurahInfo();

  print(surahInfoDetails.surahDescription["language_name"]);
}