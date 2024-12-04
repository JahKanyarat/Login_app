import 'package:flutter/material.dart';
import 'package:login_app/components/custom_button.dart';
import 'package:login_app/components/custom_textfeild.dart';
import 'package:login_app/pages/loginPage.dart';
import 'package:login_app/services/authentication_service.dart';
import 'package:login_app/services/handle_firebase_exception.dart';
import 'package:login_app/utils/load_spinner.dart';
import 'package:login_app/utils/snackbar_service.dart';
import 'package:login_app/utils/validator.dart';

class Forgotpasswordpage extends StatefulWidget {
  static const String id = 'forgotP';


  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void ForgotPassword() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final status = await AuthenticationService.resetPassword(Username: _email);
      if (status == AuthStatus.successful) {
        DisplaySpinner.hide();
        if (!mounted) return; 
        SnackbarService.DisplaySnackbar(context, "Chechk your email to reset password", SnackbarStatus.success);
        Navigator.pushNamedAndRemoveUntil(context, Loginpage.id, (route)=>false);

      }else{
        DisplaySpinner.hide();
        final err = HandleFirebaseException.generateErrMsg(status);
        SnackbarService.DisplaySnackbar(context, err, SnackbarStatus.error);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const Text("Forgot Your password",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Enter your username and we will reset your password",
                    style: TextStyle(fontSize: 18),
                  )
                ,),
              const SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Usermane', 
                      obscureText: false, 
                      hintText: 'Your email', 
                      onSaves: (newvalue){
                        _email = newvalue!;
                      }, 
                      validator: (value) => Validator.validateEmail(value ?? "")),
                      const SizedBox(
                      height: 40,
                    ),
                    CustomButton(onTap: ForgotPassword, txt: 'Continus')
                  ]
          
                ))
              ],
            ),
          ),
        )
      ),
    );
  }
}
