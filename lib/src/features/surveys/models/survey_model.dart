class SurveyModel {
  final String name;
  final DateTime dateTime;
  final String location;

  SurveyModel({
    required this.name,
    required this.dateTime,
    required this.location,
  });

  static SurveyModel fromJson(Map<String, dynamic> json) {
    return SurveyModel(
        name: json['name'],
        dateTime: json['dateTime'],
        location: json['location']);
  }

  Map<String, dynamic> toJson(SurveyModel model) {
    var _map = <String, dynamic>{};
    _map['name'] = model.name;
    _map['location'] = model.location;
    _map['dateTime'] = model.dateTime;
    return _map;
  }
}
