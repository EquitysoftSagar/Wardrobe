import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_2/model/category.dart';
import 'package:wardrobe_2/util/constants.dart';
import 'package:wardrobe_2/util/methods.dart';
import 'package:wardrobe_2/util/my_shared_preference.dart';
import 'package:wardrobe_2/view/list_view/category_list_view.dart';
import 'package:wardrobe_2/view/ui/message_ui.dart';

import 'add_category_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firebaseFirestore;

  @override
  void initState() {
    super.initState();
    _firebaseFirestore = FirebaseFirestore.instance;
    GetValue.string(Keys.token).then((value) {
      Constants.token = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Wardrobe'),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            // IconButton(icon: Icon(Icons.refresh), onPressed: onRefreshTap),
            IconButton(icon: Icon(Icons.logout), onPressed: onLogoutTap),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onFloatingButtonTap(context);
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Categories')
              .where('userId', isEqualTo: Constants.token)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print('token  stream ==> ${Constants.token}');
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(snapshot.hasData == null || snapshot.data.docs.length == 0){
                  return MessageUi.noData();
                }
                return _listWidget(snapshot.data.docs);
          },
        ));
  }

  void updateCategory(String name, String id) async {
    if (!await CommonMethod.isInternetConnected()) {
      CommonMethod.snackBarAlert(_scaffoldKey, 'No internet connection');
    } else {
      try {
        CommonMethod.showProgress(context, 'Updating category...');
        print('id ===> $id');
        print('name ===> $name');
        var _result =
            await _firebaseFirestore.collection('Categories').doc(id).update({
          "name": name,
        });
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        CommonMethod.snackBarAlert(
            _scaffoldKey, 'Error on update category try again later');
        print('error on update category ===> $e');
      }
    }
  }

  Widget _listWidget(List<QueryDocumentSnapshot> category) =>
      /* _listCategory.length != 0 ?*/ ListView.builder(
        itemBuilder: (context, index) => ListCategoryView(
          index: index,
          category: Category.fromJson(category[index].data()),
          deleteFn: _deleteCategory,
          editFn: updateCategory,
        ),
        itemCount: category.length,
        physics: BouncingScrollPhysics(),
      ) /*: MessageUi.noData()*/;

  void onFloatingButtonTap(BuildContext context) {
    CommonMethod.navigateTo(context, AddCategoryPage());
  }

  void _deleteCategory(String id) async {
    if (!await CommonMethod.isInternetConnected()) {
      CommonMethod.snackBarAlert(_scaffoldKey, 'No internet connectivity');
    } else {
      try {
        CommonMethod.showProgress(context, 'Deleting Category....');
        _firebaseFirestore = FirebaseFirestore.instance;
        await _firebaseFirestore.collection('Categories').doc(id).delete();
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        CommonMethod.snackBarAlert(_scaffoldKey, 'Error on deleting category');
        print('Error on deleting category ==> $e}');
      }
    }
  }

  void onLogoutTap() async {
    bool isClear = await Value.clear();
    if (isClear) {
      Constants.token = '';
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      CommonMethod.snackBarAlert(_scaffoldKey, 'Failed to logout');
    }
  }
}
