import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {

  static double averageRatting(List<int> ratting){
    var avgRating = 0;
    for(int i=0; i<ratting.length; i++){
      avgRating = avgRating +ratting[i];
    }
    return double.parse((avgRating/ratting.length).toStringAsFixed(1));
  }

  // toast message
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  //Snack bar message
  static snackBarMessage(String title,String message,){
   Get.snackbar(
       title,
     message,
   );
  }


}