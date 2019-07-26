import 'package:validate/validate.dart';

class Validator {
  List<String> results;

  Validator(List<String>results) {
    this.results = results;
  }

  // Return only one error
  String exec(){
    assert(this.results.length != 0);

    // Remove null results, meaning passed the validation
    var filteredResult = this.results.where((result) => result != null).toList();
    return filteredResult.length == 0 ? null: filteredResult[0];
  }

  // Return all errors
  String execAll() {
    assert(this.results.length != 0);

    // Remove null results, meaning passed the validation
    List<String> filteredResult = this.results.where((result) => result != null).toList();
    if (filteredResult.length == 0) { return null; }

    String errors = '';
    for(int i = 0; i < filteredResult.length; i++) {
      errors += '• ${filteredResult[i]}';
      if (i != filteredResult.length - 1) { errors += '\n'; }
    }
    return errors;
  }
}


class Validators {

  String isEmail(String value, [String message = 'This email address is not valid']) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return message;
    }
    return null;
  }

  String isRequired(String value, [String message = 'This field is required']) {
    try {
      Validate.notBlank(value);
    } catch (e) {
      return message;
    }
    return null;
  }

  String minLength(String value, int min, [String message]) {
    message = (message != null) ? message : 'This field must be at least $min characters long';
    if (value.length < min) {
      return message;
    }
    return null;
  }

  String maxLength(String value, int max, [String message]) {
    message = (message != null) ? message : 'This field must not be more than $max characters';
    if (value.length > max) {
      return message;
    }
    return null;
  }


}