class EngTranslation {
  String? text;

  EngTranslation({this.text});

  EngTranslation.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = text;
    return data;
  }
}

class HinTranslation {
  String? text;

  HinTranslation({this.text});

  HinTranslation.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = text;
    return data;
  }
}

// class HinglishTranslation {
//   int? resourceId;
//   String? eText;
//   String? hText;

//   HinglishTranslation({this.resourceId, this.eText, this.hText});

//   HinglishTranslation.fromJson(Map<String, dynamic> json) {
//     resourceId = json['resource_id'];
//     eText = json['text'];
//     hText = json['text'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['resource_id'] = resourceId;
//     data['text'] = eText;
//     data['text'] = hText;
//     return data;
//   }
// }
