import 'package:customer_app/model/customer_hive_model.dart';
import 'package:customer_app/model/customer_request_response_model.dart';
import 'package:customer_app/model/customer_verify_data_source.dart';
import 'package:flutter/foundation.dart';

class FetchCustomerDatailController with ChangeNotifier {
  VerifyCustomerDetail verifyCustomerDetail = VerifyCustomerDetail();
  bool _isPanDetailLoading = false;
  bool _isPostCodeLoading = false;
  String? _panVerifyErrorMsg;
  String? _postCodeVerifyErrorMsg;
  PanNumberResposeModel _panNumberResposeModel =
      PanNumberResposeModel(isValid: false, fullName: '');
  PostCodeResponseModel _postCodeResponseModel =
      PostCodeResponseModel(city: [], state: []);

  List<String> _cityList = [];
  List<String> _stateList = [];
  String _selectedCity = '';
  String _selectedState = '';
//getters
  bool get isPanDetailLoading => _isPanDetailLoading;
  bool get isPostCodeLoading => _isPostCodeLoading;
  String get panVerifyErrorMsg => _panVerifyErrorMsg!;
  String get postCodeVerifyErrorMsg => _postCodeVerifyErrorMsg!;
  PanNumberResposeModel get panNumberResponseModel => _panNumberResposeModel;
  PostCodeResponseModel get postCodeResponseModel => _postCodeResponseModel;
  List<String> get cityList => _cityList;
  List<String> get stateList => _stateList;
  String get selectedCity => _selectedCity;
  String get selectedState => _selectedState;

  addUpdateFields(CustomerDetailHiveModel customerDetailHiveModel) {
    _cityList = customerDetailHiveModel.city;
    _stateList = customerDetailHiveModel.state;
    _selectedCity = _cityList.first;
    _selectedState = _stateList.first;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  clearAddCustomerFields() {
    _panNumberResposeModel =
        PanNumberResposeModel(isValid: false, fullName: '');
    _cityList = [];
    _stateList = [];
    _selectedCity = '';
    _selectedState = '';
    notifyListeners();
  }

  set selectedState(String value) {
    _selectedState = value;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  void selectCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }

  void selectState(String state) {
    _selectedState = state;
    notifyListeners();
  }

  Future<void> fetchPanDetail(
      PanNumberRequestModel panNumberRequestModel) async {
    _isPanDetailLoading = true;
    _panVerifyErrorMsg = null;
    notifyListeners();
    try {
      _panNumberResposeModel =
          await verifyCustomerDetail.verifyPanNumber(panNumberRequestModel);
      _panVerifyErrorMsg = 'PAN Number Verified';
    } catch (e) {
      if (e is NetworkException) {
        _panVerifyErrorMsg = e.error;
      } else {
        _panVerifyErrorMsg = 'Failed to verify PAN Number';
      }
    } finally {
      _isPanDetailLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostCodeDetail(
      PostCodeRequestModel postCodeRequestModel) async {
    _isPostCodeLoading = true;
    _postCodeVerifyErrorMsg = null;
    notifyListeners();
    try {
      _postCodeResponseModel =
          await verifyCustomerDetail.verifyPostalCode(postCodeRequestModel);
      _cityList = _postCodeResponseModel.city.map((cityModel) {
        return cityModel.city;
      }).toList();
      _stateList = _postCodeResponseModel.state.map((stateModel) {
        return stateModel.state;
      }).toList();
      _selectedCity = _cityList.first;
      _selectedState = _stateList.first;
      _postCodeVerifyErrorMsg = "Postcode Verified";
    } catch (e) {
      if (e is NetworkException) {
        _postCodeVerifyErrorMsg = e.error;
      } else {
        _postCodeVerifyErrorMsg = 'Failed to verify post code';
      }
    } finally {
      _isPostCodeLoading = false;
      notifyListeners();
    }
  }
}
