import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';

class CategoryTextField extends StatelessWidget {

  final String labelText;
  final TextEditingController controller;

  const CategoryTextField({Key key, this.labelText,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColor.text,fontWeight: FontWeight.w500),
      keyboardType: TextInputType.text,
      // obscureText: labelText == 'Password' ? true : false,
      validator: (value){
        if(value.isEmpty){
          return 'Please enter category name';
        }
        return null;
      },
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
          labelText: labelText,
          errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
          labelStyle: TextStyle(color: MyColor.text,fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: MyColor.text,width: 2)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.red,width: 2)
          )
      ),
    );
  }
}
