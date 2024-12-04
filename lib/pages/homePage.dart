import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/pages/loginPage.dart';
import 'package:login_app/services/authentication_service.dart';
import 'package:login_app/utils/load_spinner.dart';

class Homepage extends StatelessWidget {
  static const String id = 'homeP';
  final user = FirebaseAuth.instance.currentUser;
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions:[IconButton(
          onPressed: ()async{DisplaySpinner.show(context);
          await AuthenticationService.signOut().then((value) {
            DisplaySpinner.hide();
            Navigator.pushNamedAndRemoveUntil(context, Loginpage.id, (routr)=> false);
          });
          }, 
          icon: const Icon(Icons.logout)
      )]
    ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(foregroundImage: NetworkImage(user!.photoURL ?? 'https://randomuser.me/portraits/thumb/men/65.jpg'),),
            const SizedBox(height: 10,),
            Text("Logged in as : ${user!.displayName?? user!.email}"),
          ],
        ),
      ),
    );
  }
}
