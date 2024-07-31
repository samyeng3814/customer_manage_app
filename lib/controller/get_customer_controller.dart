import 'package:customer_app/model/customer_hive_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GetCustomerController extends ChangeNotifier {
  List<CustomerDetailHiveModel> getAllCustomers = [];
  getLocalCustomers() async {
    Box<CustomerDetailHiveModel> customerBox =
        await Hive.openBox<CustomerDetailHiveModel>('customerBox');
    getAllCustomers = customerBox.values.toList();
    notifyListeners();
  }
}
