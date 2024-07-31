import 'package:customer_app/model/customer_hive_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerController extends ChangeNotifier {
  List<CustomerDetailHiveModel> getAllCustomers = [];
  getLocalCustomers() async {
    Box<CustomerDetailHiveModel> customerBox =
        await Hive.openBox<CustomerDetailHiveModel>('customerBox');
    getAllCustomers = customerBox.values.toList();
    notifyListeners();
  }

  Future<String> addCustomer(
    CustomerDetailHiveModel customer,
  ) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.put(customer.id, customer);
      await getLocalCustomers();
      return 'Customer successfully added';
    } catch (e) {
      return 'Failed to add customer';
    }
  }

  Future<String> updateCustomer(
    CustomerDetailHiveModel customer,
  ) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.put(customer.id, customer);
      await getLocalCustomers();
      return 'Customer successfully updated';
    } catch (e) {
      return 'Failed to update customer';
    }
  }

  Future<String> deleteCustomer(String customerId) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.delete(customerId);
      await getLocalCustomers();
      return 'Customer successfully deleted';
    } catch (e) {
      return 'Failed to delete customer';
    }
  }
}
