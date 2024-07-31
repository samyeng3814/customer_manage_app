import 'package:customer_app/controller/add_customer_controller.dart';
import 'package:customer_app/controller/get_customer_controller.dart';
import 'package:customer_app/model/customer_hive_model.dart';
import 'package:customer_app/nav/navigation.dart';
import 'package:customer_app/theme/app_colors.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/app_sized_box.dart';
import 'package:customer_app/utils/utils.dart';
import 'package:customer_app/view/pages/add_and_update_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CustomerCardWidget extends StatelessWidget {
  final CustomerDetailHiveModel customerDetailHiveModel;
  const CustomerCardWidget({super.key, required this.customerDetailHiveModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.blueColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    customerDetailHiveModel.panNumber,
                    style:
                        FontTheme.bodyText.copyWith(color: AppColors.blueColor),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showAlert(context, customerDetailHiveModel.id);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.redColor,
                        size: 24,
                      ),
                    ),
                    AppSizedBox.w6,
                    IconButton(
                      onPressed: () {
                        pushContext(
                          context,
                          route: AddAndUpdateCustomerPage(
                            pageName: 'Update',
                            customerDetailHiveModel: customerDetailHiveModel,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.customGreyColor,
                        size: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
            AppSizedBox.h4,
            Text(
              customerDetailHiveModel.name,
              style: FontTheme.title,
            ),
            AppSizedBox.h4,
            Text(
              customerDetailHiveModel.email,
              style: FontTheme.bodyText.copyWith(fontStyle: FontStyle.italic),
            ),
            AppSizedBox.h8,
            Row(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: AppColors.blueColor,
                        ),
                        AppSizedBox.w8,
                        Text(
                          customerDetailHiveModel.mobile,
                          style: FontTheme.bodyText,
                        )
                      ],
                    ),
                  ],
                ),
                AppSizedBox.w12,
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.blueColor,
                    ),
                    AppSizedBox.w8,
                    Text(
                      "${customerDetailHiveModel.city}, ${customerDetailHiveModel.state}",
                      style: FontTheme.bodyText,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context, String customerId) {
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.all(16.0),
          content: StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 46,
                    width: 46,
                    child: Icon(
                      Icons.delete_outline,
                      color: AppColors.redColor,
                    ),
                  ),
                  AppSizedBox.h12,
                  Text(
                    'Are you sure you want to delete this customer?',
                    style:
                        FontTheme.title.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  AppSizedBox.h24,
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: Colors.black,
                            elevation: 1,
                            padding: const EdgeInsets.all(16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            isLoading = true;
                            final getCustomerController =
                                context.read<GetCustomerController>();
                            context
                                .read<AddCustomerController>()
                                .deleteCustomer(
                                    customerId, getCustomerController)
                                .then((val) {
                              Future.delayed(const Duration(seconds: 2), () {
                                isLoading = false;
                                Utils.showStatusSnackBar(val, context);
                                popContext(context);
                              });
                              setState(() {});
                            });
                          },
                          child: Center(
                            child: isLoading
                                ? SpinKitThreeBounce(
                                    color: AppColors.yellowColor,
                                    size: 20,
                                  )
                                : Text(
                                    "Delete",
                                    style: FontTheme.subTitle.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      AppSizedBox.w8,
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.blackColor),
                            elevation: 1,
                            padding: const EdgeInsets.all(16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () {
                            popContext(context);
                          },
                          child: Text(
                            'Close',
                            style: FontTheme.subTitle
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
