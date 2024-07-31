import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/model/customer_request_response_model.dart';
import 'package:http/http.dart' as http;

class NetworkException implements Exception {
  final String error;
  NetworkException(this.error);
}

class VerifyCustomerDetail {
  Future<PanNumberResposeModel> verifyPanNumber(
      PanNumberRequestModel panNumberRequestModel) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    print('Connectivity result: $connectivityResult');
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw NetworkException("No Internet Connection");
    }
    String verifyPan = 'https://lab.pixel6.co/api/verify-pan.php';
    final response = await http.post(
      Uri.parse(verifyPan),
      body: json.encode(panNumberRequestModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PanNumberResposeModel.fromJson(data);
    } else {
      throw 'Failed to verify PAN Number';
    }
  }

  Future<PostCodeResponseModel> verifyPostalCode(
      PostCodeRequestModel postCodeRequestModel) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw NetworkException("No Internet Connection");
    } else {
      String getPostCodeDetails =
          'https://lab.pixel6.co/api/get-postcode-details.php';
      final response = await http.post(
        Uri.parse(getPostCodeDetails),
        body: json.encode(postCodeRequestModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final res = PostCodeResponseModel.fromJson(data);
        return res;
      } else {
        throw 'Failed to verify postal code';
      }
    }
  }
}
