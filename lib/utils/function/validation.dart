
class Validation {
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern.toString());
    if (value.trim().isEmpty) {
      return "Email is required";
    } else if ((!regex.hasMatch(value))) {
      return "Invalid email address";
    } else {
      return '';
    }
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^((?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{4,20})$';
    RegExp regex = RegExp(pattern.toString());

    if (value.trim().isEmpty) {
      return 'Password is required';
    } else if ((!regex.hasMatch(value))) {
      return 'Enter strong password';
    } else if (value.trim().length < 8) {
      return 'Password is to short';
    } else {
      return '';
    }
  }


}
