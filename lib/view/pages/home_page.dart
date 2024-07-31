import 'package:customer_app/constant/constants.dart';
import 'package:customer_app/controller/add_customer_controller.dart';
import 'package:customer_app/nav/navigation.dart';
import 'package:customer_app/theme/app_colors.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/app_sized_box.dart';
import 'package:customer_app/view/pages/add_and_update_customer_page.dart';
import 'package:customer_app/view/widgets/customer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Customers List',
          style: FontTheme.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Customers',
                  style: FontTheme.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                AppSizedBox.h12,
                SizedBox(
                  height: screenHeight - kToolbarHeight - 20 - 16,
                  child: Consumer<CustomerController>(
                      builder: (context, customerController, _) {
                    return ListView.builder(
                      itemCount: customerController.getAllCustomers.length,
                      itemBuilder: (context, index) {
                        return CustomerCardWidget(
                          customerDetailHiveModel:
                              customerController.getAllCustomers[index],
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blackColor,
        onPressed: () {
          pushContext(
            context,
            route: const AddAndUpdateCustomerPage(
              pageName: 'Add',
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
