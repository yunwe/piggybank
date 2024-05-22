import 'package:flutter/material.dart';

class AppMargin {
  static const double m8 = 8.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class AppPadding {
  static const double p8 = 8.0;
  static const double p28 = 28.0;
  static const double p20 = 20.0;
}

class AppSize {
  static const double borderRadius = 7.0;
  static const double opacity = 0.5;
  static const double formEntityWidth = 280; //Todo: Delete after fixing register.dart, forgetpassword.dart
  static const double formEntityHeight = 46;
  static const double iconSize = 28;
}

class AppKeys {
  static const Key loginUsername = Key('loginForm_usernameInput_textField');
  static const Key loginPassword = Key('loginForm_passwordInput_textField');
  static const Key loginSubmit = Key('loginForm_continue_raisedButton');
  static const Key logoutButton = Key('homePage_logout_iconButton');
  static const Key registerUsername = Key('registerForm_usernameInput_textField');
  static const Key registerPassword = Key('registerForm_passwordInput_textField');
  static const Key registerConfirmPassword = Key('registerForm_confirmPasswordInput_textField');
  static const Key registerSubmit = Key('registerForm_continue_raisedButton');
}

class FontSize {
  static const double inputFontSize = 16;
}

class DurationConstant {}
