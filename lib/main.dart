import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/firebase_options.dart';
import 'package:login_app/myrouter.dart';
import 'package:login_app/pages/loginPage.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static ButtonStyle btnSty = TextButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      fixedSize: const Size(100, 50));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginpage(),
      initialRoute: Loginpage.id,
      onGenerateRoute: Myrouter.generateRoute,
    );
  }
}
