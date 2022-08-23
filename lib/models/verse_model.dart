class VerseArabic {
  int? id;
  String? verseKey;
  String? textIndopak;

  VerseArabic({this.id, this.verseKey, this.textIndopak});

  VerseArabic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verseKey = json['verse_key'];
    textIndopak = json['text_uthmani'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['verse_key'] = verseKey;
    data['text_uthmani'] = textIndopak;
    return data;
  }
}
