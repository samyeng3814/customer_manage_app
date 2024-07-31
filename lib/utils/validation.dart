class TextFormFieldValidator {
  static validatePancard(String value) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please Enter PAN Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid PAN Number';
    } else {
      return null;
    }
  }

  static validateEmail(String value) {
    String emailRegExp =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(emailRegExp);
    if (value.isEmpty) {
      return 'Please Enter Email';
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  static validateMobileNumber(String value) {
    String mobileRegExp = r'^[4-9][0-9]{9}';
    RegExp regExp = RegExp(mobileRegExp);
    if (value.isEmpty) {
      return "Please Enter Mobile";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid mobile number";
    } else {
      return null;
    }
  }
}
