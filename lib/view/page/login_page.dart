import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/style/images.dart';
import 'package:wardrobe_2/util/methods.dart';
import 'package:wardrobe_2/util/my_shared_preference.dart';
import 'package:wardrobe_2/view/ui/login_text_field.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _firebaseAuth;

  @override
  Widget build(BuildContext context) {
    _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Wardrobe',
                    style: TextStyle(
                        color: MyColor.text,
                        shadows: [
                          Shadow(color: MyColor.shadow, blurRadius: 3),
                        ],
                        fontWeight: FontWeight.w600,
                        fontSize: 35),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    MyImages.wardrobe,
                    height: 125,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: MyColor.text,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  LoginTextField(
                    labelText: 'Email',
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  LoginTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  RaisedButton(
                    onPressed: () {
                      onLoginTap(context);
                    },
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLoginTap(BuildContext context) {
    if (_formKey.currentState.validate()) {
      apiLogin(context);
    }
  }

  void apiLogin(BuildContext context) async {
    if(!await CommonMethod.isInternetConnected()){
      CommonMethod.snackBarAlert(_scaffoldKey, 'No Internet Connection');
    }else{
      CommonMethod.showProgress(context, 'Login...');
      try{
        var _result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        print('token ===> ${_result.user.uid}');
        await SaveValue.string(Keys.token, _result.user.uid);
        Navigator.pop(context);
        CommonMethod.navigateTo(context, HomePage());

      } on FirebaseAuthException catch(error){
        Navigator.pop(context);
        print('error code ==> ${error.code}');
        if (error.code == 'user-not-found') {
          CommonMethod.snackBarAlert(_scaffoldKey, 'User is not found with this email');
        } else if (error.code == 'email-already-in-use') {
          CommonMethod.snackBarAlert(_scaffoldKey, 'The account already exists for that email.');
        } else if(error.code == 'wrong-password'){
          CommonMethod.snackBarAlert(_scaffoldKey, 'Password is wrong');
        }
      } catch (e){
        CommonMethod.snackBarAlert(_scaffoldKey, 'something went wrong try again later');
        print('error on Login ===> $e');
      }
    }
  }
}
