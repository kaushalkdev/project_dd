class GeneralQuestions {
  RespName? respName;
  RespFamily? respFamily;
  RespFamily? respAge;
  RespFamily? respGender;
  RespFamily? respMarrige;
  RespFamily? respChildren;
  RespFamily? respGirls;
  RespFamily? respHouse;
  RespFamily? respToiletAccess;
  RespFamily? respToiletType;
  RespFamily? respLight;
  RespFamily? respCooking;
  RespFamily? respWater;

  GeneralQuestions(
      {this.respName,
      this.respFamily,
      this.respAge,
      this.respGender,
      this.respMarrige,
      this.respChildren,
      this.respGirls,
      this.respHouse,
      this.respToiletAccess,
      this.respToiletType,
      this.respLight,
      this.respCooking,
      this.respWater});

  GeneralQuestions.fromJson(Map<String, dynamic> json) {
    respName =
        json['resp_name'] != null ? RespName.fromJson(json['resp_name']) : null;
    respFamily = json['resp_family'] != null
        ? RespFamily.fromJson(json['resp_family'])
        : null;
    respAge =
        json['resp_age'] != null ? RespFamily.fromJson(json['resp_age']) : null;
    respGender = json['resp_gender'] != null
        ? RespFamily.fromJson(json['resp_gender'])
        : null;
    respMarrige = json['resp_marrige'] != null
        ? RespFamily.fromJson(json['resp_marrige'])
        : null;
    respChildren = json['resp_children'] != null
        ? RespFamily.fromJson(json['resp_children'])
        : null;
    respGirls = json['resp_girls'] != null
        ? RespFamily.fromJson(json['resp_girls'])
        : null;
    respHouse = json['resp_house'] != null
        ? RespFamily.fromJson(json['resp_house'])
        : null;
    respToiletAccess = json['resp_toilet_access'] != null
        ? RespFamily.fromJson(json['resp_toilet_access'])
        : null;
    respToiletType = json['resp_toilet_type'] != null
        ? RespFamily.fromJson(json['resp_toilet_type'])
        : null;
    respLight = json['resp_light'] != null
        ? RespFamily.fromJson(json['resp_light'])
        : null;
    respCooking = json['resp_cooking'] != null
        ? RespFamily.fromJson(json['resp_cooking'])
        : null;
    respWater = json['resp_water'] != null
        ? RespFamily.fromJson(json['resp_water'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (respName != null) {
      data['resp_name'] = respName!.toJson();
    }
    if (respFamily != null) {
      data['resp_family'] = respFamily!.toJson();
    }
    if (respAge != null) {
      data['resp_age'] = respAge!.toJson();
    }
    if (respGender != null) {
      data['resp_gender'] = respGender!.toJson();
    }
    if (respMarrige != null) {
      data['resp_marrige'] = respMarrige!.toJson();
    }
    if (respChildren != null) {
      data['resp_children'] = respChildren!.toJson();
    }
    if (respGirls != null) {
      data['resp_girls'] = respGirls!.toJson();
    }
    if (respHouse != null) {
      data['resp_house'] = respHouse!.toJson();
    }
    if (respToiletAccess != null) {
      data['resp_toilet_access'] = respToiletAccess!.toJson();
    }
    if (respToiletType != null) {
      data['resp_toilet_type'] = respToiletType!.toJson();
    }
    if (respLight != null) {
      data['resp_light'] = respLight!.toJson();
    }
    if (respCooking != null) {
      data['resp_cooking'] = respCooking!.toJson();
    }
    if (respWater != null) {
      data['resp_water'] = respWater!.toJson();
    }
    return data;
  }
}

class RespName {
  String? name;

  RespName({this.name});

  RespName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class RespFamily {
  String? name;
  List<String>? options;

  RespFamily({this.name, this.options});

  RespFamily.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['options'] = options;
    return data;
  }
}
