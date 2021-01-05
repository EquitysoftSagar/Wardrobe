import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String title;

  const ProgressDialog({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 15,bottom: 15 ,left: 15,right: 15),
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20,),
            Flexible(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
