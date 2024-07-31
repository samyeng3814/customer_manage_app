import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/model/customer_request_response_model.dart';
import 'package:http/http.dart' as http;

class VerifyUserDetail {
  Future<PanNumberResposeModel> verifyPanNumber() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw "No Internet Connection";
    } else {
      String verifyPan = 'https://lab.pixel6.co/api/verify-pan.php';
      final response = await http.post(Uri.parse(verifyPan));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PanNumberResposeModel.fromJson(data);
      } else {
        throw 'Failed to verify PAN Number';
      }
    }
  }

  Future<PostCodeResponseModel> verifyPostalCode() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw "No Internet Connection";
    } else {
      String getPostCodeDetails =
          'https://lab.pixel6.co/api/get-postcode-details.php';
      final response = await http.post(Uri.parse(getPostCodeDetails));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PostCodeResponseModel.fromJson(data);
      } else {
        throw 'Failed to verify postal code';
      }
    }
  }
}
