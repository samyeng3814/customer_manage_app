class PanNumberRequestModel {
  final String panNumber;
  PanNumberRequestModel({required this.panNumber});

  Map<String, dynamic> toJson() {
    return {'panNumber': panNumber};
  }
}

class PostCodeRequestModel {
  final String postCode;
  PostCodeRequestModel({
    required this.postCode,
  });
  Map<String, dynamic> toJson() {
    return {
      'postcode': postCode,
    };
  }
}

class PanNumberResposeModel {
  final bool isValid;
  final String fullName;

  PanNumberResposeModel({
    required this.isValid,
    required this.fullName,
  });

  factory PanNumberResposeModel.fromJson(Map<String, dynamic> json) {
    return PanNumberResposeModel(
      isValid: json['isValid'],
      fullName: json['fullName'],
    );
  }
}

class PostCodeResponseModel {
  final List<CityModel> city;
  final List<StateModel> state;
  PostCodeResponseModel({
    required this.city,
    required this.state,
  });

  factory PostCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return PostCodeResponseModel(
      city: (json['city'] as List<dynamic>)
          .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      state: (json['state'] as List<dynamic>)
          .map((item) => StateModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CityModel {
  final int id;
  final String city;

  CityModel({
    required this.id,
    required this.city,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      city: json['name'],
    );
  }
}

class StateModel {
  final int id;
  final String state;

  StateModel({
    required this.id,
    required this.state,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      state: json['name'],
    );
  }
}
