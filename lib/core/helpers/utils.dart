import 'package:flutter/material.dart';

class Utils {

  // Used in for TextFormFields 'onFieldSubmitted' to perform focus on the next TextFormField
  static void fieldFocusChange(context, currentNodeFocus, nextNodeFocus) {
    currentNodeFocus.unfocus();
    FocusScope.of(context).requestFocus(nextNodeFocus);
  }

}