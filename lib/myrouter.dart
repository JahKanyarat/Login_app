import 'package:flutter/material.dart';
import 'package:login_app/pages/forgotpasswordPage.dart';
import 'package:login_app/pages/homePage.dart';
import 'package:login_app/pages/loginPage.dart';
import 'package:login_app/pages/registerPage.dart';

class Myrouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Loginpage.id:
        return MaterialPageRoute(builder: (_) => const Loginpage());
      case Registerpage.id:
        return MaterialPageRoute(builder: (_) => const Registerpage());
      case Forgotpasswordpage.id:
        return MaterialPageRoute(builder: (_) => const Forgotpasswordpage());
      case Homepage.id:
        return MaterialPageRoute(builder: (_) => Homepage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("Page NOT found"),
                  ),
                ));
    }
  }
}
