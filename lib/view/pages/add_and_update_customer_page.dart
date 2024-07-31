import 'package:customer_app/controller/add_customer_controller.dart';
import 'package:customer_app/controller/fetch_customer_detail_controller.dart';
import 'package:customer_app/model/customer_hive_model.dart';
import 'package:customer_app/model/customer_request_response_model.dart';
import 'package:customer_app/nav/navigation.dart';
import 'package:customer_app/theme/app_colors.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/app_sized_box.dart';
import 'package:customer_app/utils/utils.dart';
import 'package:customer_app/utils/validation.dart';
import 'package:customer_app/view/widgets/build_custom_dropdown.dart';
import 'package:customer_app/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddAndUpdateCustomerPage extends StatefulWidget {
  final String pageName;
  final CustomerDetailHiveModel? customerDetailHiveModel;
  const AddAndUpdateCustomerPage(
      {super.key, required this.pageName, this.customerDetailHiveModel});

  @override
  State<AddAndUpdateCustomerPage> createState() =>
      AddAndUpdateCustomerPageState();
}

class AddAndUpdateCustomerPageState extends State<AddAndUpdateCustomerPage> {
  TextEditingController panNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  final FocusNode panNumberFocusNode = FocusNode();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode addressLine1FocusNode = FocusNode();
  final FocusNode addressLine2FocusNode = FocusNode();
  final FocusNode postCodeFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    if (widget.customerDetailHiveModel != null) {
      var verifyController = context.read<FetchCustomerDatailController>();
      var customerModel = widget.customerDetailHiveModel;
      panNumberController =
          TextEditingController(text: customerModel!.panNumber);
      fullNameController = TextEditingController(text: customerModel.name);
      emailController = TextEditingController(text: customerModel.email);
      mobileNumberController =
          TextEditingController(text: customerModel.mobile);
      addressLine1Controller =
          TextEditingController(text: customerModel.addressLine1);
      addressLine2Controller =
          TextEditingController(text: customerModel.addressLine2);
      postCodeController =
          TextEditingController(text: customerModel.postalCode);
      verifyController.cityList = customerModel.city;
      verifyController.stateList = customerModel.state;
    }
  }

  @override
  void dispose() {
    super.dispose();
    panNumberController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    postCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text(
          '${widget.pageName} Customer',
          style: FontTheme.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Consumer<FetchCustomerDatailController>(
                        builder: (context, controller, _) {
                          final panNumberResponseModel =
                              controller.panNumberResponseModel;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (panNumberResponseModel.isValid &&
                                fullNameController.text !=
                                    panNumberResponseModel.fullName) {
                              fullNameController.text =
                                  panNumberResponseModel.fullName;
                            }
                          });
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PAN Number",
                                      style: FontTheme.subTitle.copyWith(
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    AppSizedBox.h8,
                                    CustomTextField(
                                      controller: panNumberController,
                                      isBorderEnabled: true,
                                      focusNode: panNumberFocusNode,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' '),
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[A-Z0-9]'),
                                        ),
                                      ],
                                      maxLength: 10,
                                      suffix: controller.isPanDetailLoading
                                          ? SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: SpinKitFadingCircle(
                                                color: AppColors.yellowColor,
                                                size: 24,
                                              ),
                                            )
                                          : const SizedBox(),
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context)
                                            .requestFocus(fullNameFocusNode);
                                        var panNumberRequestModel =
                                            PanNumberRequestModel(
                                                panNumber: val);
                                        context
                                            .read<
                                                FetchCustomerDatailController>()
                                            .fetchPanDetail(
                                                panNumberRequestModel)
                                            .then((_) {
                                          Utils.showStatusSnackBar(
                                              controller.panVerifyErrorMsg,
                                              context);
                                        });
                                      },
                                      validator: (value) =>
                                          TextFormFieldValidator
                                              .validatePancard(value!),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Full Name",
                                      style: FontTheme.subTitle.copyWith(
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    AppSizedBox.h8,
                                    CustomTextField(
                                      controller: fullNameController,
                                      isBorderEnabled: true,
                                      focusNode: fullNameFocusNode,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[A-Za-z ]'),
                                        ),
                                      ],
                                      maxLength: 140,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context)
                                            .requestFocus(emailFocusNode);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Full Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: FontTheme.subTitle.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                            ),
                            AppSizedBox.h8,
                            CustomTextField(
                              controller: emailController,
                              isBorderEnabled: true,
                              focusNode: emailFocusNode,
                              maxLength: 255,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(mobileNumberFocusNode);
                              },
                              validator: (value) =>
                                  TextFormFieldValidator.validateEmail(value!),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile Number",
                              style: FontTheme.subTitle.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                            ),
                            AppSizedBox.h8,
                            CustomTextField(
                              controller: mobileNumberController,
                              isBorderEnabled: true,
                              focusNode: mobileNumberFocusNode,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(addressLine1FocusNode);
                              },
                              keyboardType: TextInputType.number,
                              prefix: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: AppColors.hintTextColor,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      '+91',
                                      style: FontTheme.bodyText,
                                    ),
                                  ),
                                ],
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              maxLength: 10,
                              validator: (value) =>
                                  TextFormFieldValidator.validateMobileNumber(
                                      value!),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address Line 1",
                              style: FontTheme.subTitle.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                            ),
                            AppSizedBox.h8,
                            CustomTextField(
                              controller: addressLine1Controller,
                              isBorderEnabled: true,
                              focusNode: addressLine1FocusNode,
                              maxLength: 255,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(addressLine2FocusNode);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Address';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address Line 2",
                              style: FontTheme.subTitle.copyWith(
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                            ),
                            AppSizedBox.h8,
                            CustomTextField(
                              controller: addressLine2Controller,
                              isBorderEnabled: true,
                              maxLength: 255,
                              focusNode: addressLine2FocusNode,
                              onFieldSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(postCodeFocusNode);
                              },
                            ),
                          ],
                        ),
                      ),
                      Consumer<FetchCustomerDatailController>(
                        builder: (context, controller, _) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Post Code",
                                      style: FontTheme.subTitle.copyWith(
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    AppSizedBox.h8,
                                    CustomTextField(
                                      controller: postCodeController,
                                      isBorderEnabled: true,
                                      focusNode: postCodeFocusNode,
                                      keyboardType: TextInputType.number,
                                      suffix: controller.isPostCodeLoading
                                          ? SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: SpinKitFadingCircle(
                                                color: AppColors.yellowColor,
                                                size: 24,
                                              ),
                                            )
                                          : const SizedBox(),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'),
                                        ),
                                      ],
                                      maxLength: 6,
                                      onFieldSubmitted: (value) {
                                        var postCodeRequestModel =
                                            PostCodeRequestModel(
                                                postCode: value);
                                        context
                                            .read<
                                                FetchCustomerDatailController>()
                                            .fetchPostCodeDetail(
                                                postCodeRequestModel)
                                            .then((_) {
                                          Utils.showStatusSnackBar(
                                              controller.postCodeVerifyErrorMsg,
                                              context);
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Postcode";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "state",
                                            style: FontTheme.subTitle.copyWith(
                                              color: AppColors.blackColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          AppSizedBox.h8,
                                          BuildCustomDropdown(
                                            value: controller.selectedState,
                                            items: controller.stateList,
                                            onChanged: (selectedState) {
                                              controller
                                                  .selectState(selectedState!);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  AppSizedBox.w12,
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "city",
                                            style: FontTheme.subTitle.copyWith(
                                              color: AppColors.blackColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          AppSizedBox.h8,
                                          BuildCustomDropdown(
                                            value: controller.selectedCity,
                                            items: controller.cityList,
                                            onChanged: (selectedCity) {
                                              controller
                                                  .selectCity(selectedCity!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                AppSizedBox.h12,
                ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, _) {
                    return ElevatedButton(
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
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          isLoading.value = true;
                          _formKey.currentState!.save();
                          final customerId = const Uuid().v4();
                          var verifyController =
                              context.read<FetchCustomerDatailController>();
                          if (widget.pageName == "Add") {
                            context
                                .read<CustomerController>()
                                .addCustomer(
                                  CustomerDetailHiveModel(
                                    id: customerId,
                                    panNumber: panNumberController.text,
                                    name: fullNameController.text,
                                    mobile: mobileNumberController.text,
                                    email: emailController.text,
                                    city: verifyController.cityList,
                                    state: verifyController.stateList,
                                    addressLine1: addressLine1Controller.text,
                                    addressLine2: addressLine2Controller.text,
                                    postalCode: postCodeController.text,
                                  ),
                                )
                                .then((value) {
                              Future.delayed(const Duration(seconds: 2), () {
                                isLoading.value = false;
                                Utils.showStatusSnackBar(value, context);
                                popContext(context);
                              });
                            });
                          } else if (widget.pageName == "Update") {
                            context
                                .read<CustomerController>()
                                .updateCustomer(
                                  CustomerDetailHiveModel(
                                    id: widget.customerDetailHiveModel!.id,
                                    panNumber: panNumberController.text,
                                    name: fullNameController.text,
                                    mobile: mobileNumberController.text,
                                    email: emailController.text,
                                    city: verifyController.cityList,
                                    state: verifyController.stateList,
                                    addressLine1: addressLine1Controller.text,
                                    addressLine2: addressLine2Controller.text,
                                    postalCode: postCodeController.text,
                                  ),
                                )
                                .then((value) {
                              Future.delayed(const Duration(seconds: 2), () {
                                isLoading.value = false;
                                Utils.showStatusSnackBar(value, context);
                                popContext(context);
                              });
                            });
                          }
                        }
                      },
                      child: value
                          ? SpinKitThreeBounce(
                              color: AppColors.yellowColor,
                              size: 24,
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  widget.pageName,
                                  style: FontTheme.subTitle.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
