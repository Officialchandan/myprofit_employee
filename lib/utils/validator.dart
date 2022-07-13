import 'package:flutter/material.dart';

class Validator {
  static RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static String? emailValidator(String email) {
    if (email.isEmpty) {
      return null;
    }

    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email address';
    }
    return null;
  }

  //mobile-validator
  static String? validatename(String value, BuildContext context) {
    String patttern = r'([a-zA-Z ])';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "please enter  Name";
    } else if (!regExp.hasMatch(value)) {
      return "please enter Valid Name";
    }
    return null;
  }

  static String? validateAddres(String value, BuildContext context) {
    String patttern = r'([a-zA-Z ][0-9][\])';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "please enter  Name";
    } else if (!regExp.hasMatch(value)) {
      return "please enter Valid Name";
    }
    return null;
  }

//
  static String? validateMobile(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "please enter mobile number";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile number must be digits";
    }
    return null;
  }

  static String? validateAccountNumber(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "please enter Account number";
    } else if (value.length != 16) {
      return "Account number must 16 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Account number must be digits";
    }
    return null;
  }

  static String? validatePincode(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "please enter PinCode number";
    } else if (value.length != 6) {
      return "PinCode number must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "PinCode number must be digits";
    }
    return null;
  }

  //employee-validator
  static String? validateEmployee(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter employee";
    } else if (!regExp.hasMatch(value)) {
      return "Employee must be digits";
    }
    return null;
  }

  //main-mrp-validator
  static String? validateMainMrp(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter price";
    } else if (!regExp.hasMatch(value)) {
      return "Price must be digits";
    }
    return null;
  }

  //aadhar-number-validator
  static String? validateAaadharNumber(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter aadhar number";
    } else if (!regExp.hasMatch(value)) {
      return "Aadhar number must be digits";
    }
    return null;
  }

  //aadhar-number-validator
  static String? validateIFSC(String value, BuildContext context) {
    String patttern = r'^[A-Za-z]{4}[a-zA-Z0-9]{7}$';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter IFSC number";
    } else if (!regExp.hasMatch(value)) {
      return "IFSC number must be in proper Formate";
    }
    return null;
  }

  //truck-traffic-validator
  static String? validateTruckTraffic(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter daily truck traffic";
    } else if (!regExp.hasMatch(value)) {
      return "Daily truck traffic must be digits";
    }
    return null;
  }

  //distance-bank-validator
  static String? validateDistanceBank(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter distance from bank";
    } else if (!regExp.hasMatch(value)) {
      return "Distance from bank must be digits";
    }
    return null;
  }

  //seating-capacity-validator
  static String? validateSeatingCapacity(String value, BuildContext context) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Please enter seating capacity";
    } else if (!regExp.hasMatch(value)) {
      return "Seating capacity must be digits";
    }
    return null;
  }

  static String? passwordValidator(String password) {
    if (password.isEmpty) {
      return null;
    }
    // if (!passwordRegex.hasMatch(password)) {
    //   return '';
    // }
    return null;
  }
}
