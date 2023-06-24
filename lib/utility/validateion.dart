class Validation {
  static String? isEmptyField(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  static bool validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return true;
    }
    List<String> splitValue = value.split(" ");
    if (splitValue.last.length != 10) {
      return true;
    }
    return false;
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    String? isEmpty = isEmptyField(value);

    // ignore: unnecessary_null_comparison
    if (isEmpty != null) {
      return isEmpty;
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validatePassword(String value) {
    String? isEmpty = isEmptyField(value);
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regExp = RegExp(pattern);

    // ignore: unnecessary_null_comparison
    if (isEmpty != null) {
      return isEmpty;
    } else if (!regExp.hasMatch(value)) {
      return "Minimum eight characters, at least one letter and one number";
    }
    return null;
  }
}
