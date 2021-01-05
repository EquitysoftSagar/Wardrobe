import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_2/view/dialog/progress_dialog.dart';

class CommonMethod{
  static void navigateTo<T>(BuildContext context, Widget widget,{ValueChanged<T> result}) {
    if(result != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget)).then((value) => result(value));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    }
  }
  static void showProgress(BuildContext context,String title){
    showDialog(
        context: context,
        barrierDismissible: false,
        child: ProgressDialog(
          title: title,
        ));
  }
  static snackBarAlert(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}