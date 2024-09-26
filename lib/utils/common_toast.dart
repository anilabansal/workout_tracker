import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';
import 'common_text.dart';

class ShowToast {
  static void show(
      {required String msg,
      }) {
    fToast!.showToast(
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            color: Colors.red,
          ),
          child:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            child: CommonText(text: msg,fontSize: 16,color: Colors.white,softWrap: true,textAlign: TextAlign.center,),
          ),
        )
    );
  }
}