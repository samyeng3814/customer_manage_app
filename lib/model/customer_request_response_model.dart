class PanNumberRequestModel {
  final String panNumber;
  PanNumberRequestModel({required this.panNumber});

  Map<String, dynamic> toJson() {
    return {'panNumber': panNumber};
  }
}

class PostCodeRequestModel {
  final int postCode;
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
  final String status;
  final int statusCode;
  final bool isValid;
  final String fullName;

  PanNumberResposeModel({
    required this.status,
    required this.statusCode,
    required this.isValid,
    required this.fullName,
  });

  factory PanNumberResposeModel.fromJson(Map<String, dynamic> json) {
    return PanNumberResposeModel(
      status: json['status'],
      statusCode: json['statusCode'],
      isValid: json['isValid'],
      fullName: json['fullName'],
    );
  }
}

class PostCodeResponseModel {
  final String status;
  final int statusCode;
  final int postCode;
  final List<CityModel> city;
  final List<StateModel> state;
  PostCodeResponseModel({
    required this.status,
    required this.statusCode,
    required this.postCode,
    required this.city,
    required this.state,
  });

  factory PostCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return PostCodeResponseModel(
      status: json['status'],
      statusCode: json['statuCode'],
      postCode: json['postcode'],
      city: json['city'],
      state: json['state'],
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
      city: json['city'],
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
      state: json['state'],
    );
  }
}
