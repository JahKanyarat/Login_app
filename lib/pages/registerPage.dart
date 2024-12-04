import 'package:flutter/material.dart';
import 'package:login_app/components/custom_button.dart';
import 'package:login_app/components/custom_textfeild.dart';
import 'package:login_app/components/square_tile.dart';
import 'package:login_app/pages/forgotpasswordPage.dart';
import 'package:login_app/pages/homePage.dart';
import 'package:login_app/services/authentication_service.dart';
import 'package:login_app/services/handle_firebase_exception.dart';
import 'package:login_app/utils/load_spinner.dart';
import 'package:login_app/utils/snackbar_service.dart';
import 'package:login_app/utils/validator.dart';

class Registerpage extends StatefulWidget {
  static const String id = 'regisP';
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  String _us = '';
  String _ps = '';
  String _conps = '';

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      DisplaySpinner.show(context);
      if (_ps != _conps) {
        DisplaySpinner.hide();
        if (!mounted) return; 
        SnackbarService.DisplaySnackbar(context, "Password nor match", SnackbarStatus.error);
      }
      else{
         final status =
          await AuthenticationService.createNewAccount(username: _us, password: _ps);
      if (status == AuthStatus.successful) {
        DisplaySpinner.hide();
        if (!mounted) {
          return;
        }
        SnackbarService.DisplaySnackbar(
            context, "Register success", SnackbarStatus.success);
        Navigator.pushNamedAndRemoveUntil(
            context, Homepage.id, (route) => false);
      } else {
        final err = HandleFirebaseException.generateErrMsg(status);
        DisplaySpinner.hide();
        if (!mounted) return;
        {
          SnackbarService.DisplaySnackbar(context, err, SnackbarStatus.error);
        }
      }
      _formKey.currentState!.reset();
      }
    }
  }

  void signinWithGoogleOAuth()async{
    DisplaySpinner.show(context);
    final status = await AuthenticationService.signinWithGoogle();
    if (status == AuthStatus.successful) {
      DisplaySpinner.hide();
      if (!mounted) return; 
      SnackbarService.DisplaySnackbar(context, "Sign in success with google", SnackbarStatus.success);
      Navigator.pushNamedAndRemoveUntil(context, Homepage.id, (route) => false);
    }
    else{
      final err = HandleFirebaseException.generateErrMsg(status);
      DisplaySpinner.hide();
      if (!mounted) {
        SnackbarService.DisplaySnackbar(context, err, SnackbarStatus.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // Padding(padding: EdgeInsets.all(10)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            CustomTextField(
                                label: "Username",
                                obscureText: false,
                                hintText: "Enter your username",
                                onSaves: (newValue) {
                                  _us = newValue!;
                                },
                                validator: (value) =>
                                    Validator.validateEmail(value ?? "")),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomTextField(
                                label: "Password",
                                obscureText: true,
                                hintText: "Enter your password",
                                onSaves: (newValue) {
                                  _ps = newValue!;
                                },
                                validator: (value) =>
                                    Validator.validatePassword(value ?? "")
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomTextField(
                                label: "Confirm Password",
                                obscureText: true,
                                hintText: "Confirm your password",
                                onSaves: (newValue) {
                                  _conps = newValue!;
                                },
                                validator: (value) => null),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomButton(onTap: signUp, txt: 'Sing in'),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey[400],
                                  thickness: 0.8,
                                )),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text("or continue with"),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey[400],
                                  thickness: 0.8,
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SquareTile(
                                    imagePath: "assets/images/google.png",
                                    onTap: signinWithGoogleOAuth),
                                const SizedBox(height: 20,),
                                SquareTile(
                                    imagePath: "assets/images/facebook.png",
                                    onTap: () {}),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
