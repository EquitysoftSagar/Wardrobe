import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_2/model/category.dart';
import 'package:wardrobe_2/util/constants.dart';
import 'package:wardrobe_2/util/methods.dart';
import 'package:wardrobe_2/view/ui/category_text_field.dart';

import 'add_category_widget/add_image_widget.dart';

class AddCategoryPage extends StatelessWidget {
  final _categoryNameController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, Object>> _imgMap = [];
  List<String> _imageUploadLink = [];

  FirebaseFirestore _firebaseFirestore;
  FirebaseStorage _storage;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Category'),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: _formKey,
                child: CategoryTextField(
                  labelText: 'Category Name',
                  controller: _categoryNameController,
                )),
            AddCategoryImageWidget(
              imgMap: _imgMap,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                onSubmitTap(context);
              },
              child: Text('Submit'),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void onSubmitTap(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _uploadImagesToCloudStorage(context);
    }
  }

  Future<void> _uploadImagesToCloudStorage(BuildContext context) async {
    if (!await CommonMethod.isInternetConnected()) {
      CommonMethod.snackBarAlert(_scaffoldKey, 'No internet connectivity');
    } else {
      CommonMethod.showProgress(context, 'Uploading images....');
      try {
        _storage = FirebaseStorage.instance;
        _imageUploadLink = [];
        for (int i = 0; i < _imgMap.length; i++) {
          String fileName = DateTime
              .now()
              .microsecondsSinceEpoch
              .toString();
          Reference ref = _storage.ref().child(
              "Category_image/$fileName.jpeg");
          var _uploadTask = ref.putFile(File(_imgMap[i]['image']));
          var shot = await _uploadTask.whenComplete(() {});
          var uri = await shot.ref.getDownloadURL();
          _imageUploadLink.add(uri);
          print('uri $i ===> $uri');
        }
        Navigator.pop(context);
          addCategoryOnServer(context);
      } catch (e) {
        Navigator.pop(context);
        CommonMethod.snackBarAlert(
            _scaffoldKey, 'Error on uploading image');
        print('error on uploading image ==> $e}');
      }
    }
  }

  void addCategoryOnServer(BuildContext context) async {
    if (!await CommonMethod.isInternetConnected()) {
      CommonMethod.snackBarAlert(_scaffoldKey, 'No internet connectivity');
    } else {
      Category c = Category();
      c.id = DateTime.now().microsecondsSinceEpoch.toString();
      c.name = _categoryNameController.text;
      c.userId = Constants.token;
      c.images = _imageUploadLink;

      _firebaseFirestore = FirebaseFirestore.instance;

      try {
        CommonMethod.showProgress(context, 'Adding Category....');
        var _result =
        await _firebaseFirestore.collection('Categories').doc(c.id).set(c.toJson());
        Navigator.pop(context);
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        CommonMethod.snackBarAlert(
            _scaffoldKey, 'Something went wrong try again later');
        print('error on adding category ==> $e}');
      }
    }
  }
}
