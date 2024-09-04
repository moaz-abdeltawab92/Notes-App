import 'package:flutter/material.dart';

class ErrorConstants {
  static String registerErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'weak-password':
        return "change password";
      case 'email-already-in-use':
        return "change this email";
      case 'invalid-email':
        return "not valid email";
      case 'operation-not-allowed':
        return "hello";
      case 'too-many-requests':
        return "aaaaa";
      default:
        return "===========a231242532534652";
    }
  }

  static String loginErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return "error";
      case 'user-not-found':
        return "error222";
      case 'network-request-failed':
        return "error333";
      case 'wrong-password':
        return "error44";
      case 'invalid-email':
        return "error555";
      case 'user-disabled':
        return "error66";
      case 'too-many-requests':
        return "error777";
      default:
        return "noo";
    }
  }
}
