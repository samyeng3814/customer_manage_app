import 'package:customer_app/controller/add_customer_controller.dart';
import 'package:customer_app/controller/get_customer_controller.dart';
import 'package:customer_app/hive/hive_adaptor.dart';
import 'package:customer_app/model/customer_hive_model.dart';
import 'package:customer_app/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CustomerHiveModelAdaptor());
  await Hive.openBox<CustomerDetailHiveModel>('customerBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetCustomerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddCustomerController(),
        ),
      ],
      child: const MaterialApp(
        title: 'Customer App',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
