import 'package:customer_app/controller/get_customer_controller.dart';
import 'package:customer_app/model/customer_hive_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCustomerController extends ChangeNotifier {
  Future<String> addCustomer(CustomerDetailHiveModel customer,
      GetCustomerController getCustomerController) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.put(customer.id, customer);
      await getCustomerController.getLocalCustomers();
      return 'Customer successfully added';
    } catch (e) {
      return 'Failed to add customer';
    }
  }

  Future<String> updateCustomer(CustomerDetailHiveModel customer,
      GetCustomerController getCustomerController) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.delete(customer.id);
      await customerBox.put(customer.id, customer);
      await getCustomerController.getLocalCustomers();
      return 'Customer successfully updated';
    } catch (e) {
      return 'Failed to update customer';
    }
  }

  Future<String> deleteCustomer(
      String customerId, GetCustomerController getCustomerController) async {
    try {
      Box<CustomerDetailHiveModel> customerBox =
          Hive.box<CustomerDetailHiveModel>('customerBox');
      await customerBox.delete(customerId);
      await getCustomerController.getLocalCustomers();
      return 'Customer successfully deleted';
    } catch (e) {
      return 'Failed to delete customer';
    }
  }
}
