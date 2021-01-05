import 'package:flutter/material.dart';
import 'package:wardrobe_2/util/constants.dart';
import 'package:wardrobe_2/style/colors.dart';

class LoginTextField extends StatelessWidget {

  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;

  const LoginTextField({Key key, this.labelText,this.controller,this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColor.text,fontWeight: FontWeight.w500),
      keyboardType: TextInputType.text,
      obscureText: labelText == 'Password' ? true : false,
      validator: (value){
        switch(labelText){
          case 'Email':
            if(value.isEmpty){
              return 'Please enter your email';
            }else if(!Constants.emailRegExp.hasMatch(value)){
              return 'Please enter valid email';
            }
            return null;
          case 'Password':
            if(value.isEmpty){
              return 'Please enter your password';
            }
            return null;
          default :
            return null;
        }
      },
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
          labelText: labelText,
          errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
          labelStyle: TextStyle(color: MyColor.text,fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red,width: 2)
          )
      ),
    );
  }
}
