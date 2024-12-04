import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lottie/lottie.dart';

class LoadSpinner extends StatelessWidget {
  const LoadSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Lottie.asset("assets/json/loading.json"),
    );
  }
}

class DisplaySpinner {
  static show(BuildContext context){
    return Loader.show(context,progressIndicator: const LoadSpinner(),overlayColor: Colors.grey[100]);
  } 

  static hide(){
    return Loader.hide();
  }
}