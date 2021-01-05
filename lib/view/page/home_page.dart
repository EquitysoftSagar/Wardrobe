import 'package:cloud_firestore/cloud_firestore.dart';
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
  Widget _activeWidget = Container();
  List<Category> _listCategory = [];

  @override
  void initState() {
    super.initState();
    GetValue.string(Keys.token).then((value) {
      Constants.token = value;
      apiGetCategory();
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
            IconButton(icon: Icon(Icons.refresh), onPressed: onRefreshTap)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onFloatingButtonTap(context);
          },
          child: Icon(Icons.add),
        ),
        body: _activeWidget);
  }

  void apiGetCategory() async {
    if (!await CommonMethod.isInternetConnected()) {
      setState(() {
        _activeWidget = MessageUi.noInternet(onRetry: onRetry,);
      });
    } else {
      try{
        CommonMethod.showProgress(context, 'Fetching category...');
        _firebaseFirestore = FirebaseFirestore.instance;
        _firebaseFirestore
            .collection(Constants.collectionCategory)
            .where('userId', isEqualTo: Constants.token)
            .get()
            .then((value) {
          Navigator.pop(context);
          _listCategory = [];
          value.docs.forEach((element) {
            _listCategory.add(Category.fromJson(element.data()));
          });

          setState(() {
            _activeWidget = _listCategory.length != 0 ? _listWidget : MessageUi.noData();
          });
        });
      } catch (e){
        Navigator.pop(context);
        setState(() {
          _activeWidget = MessageUi.wentWrong(onRetry: onRetry,);
        });
      }
    }
  }

  Widget get _listWidget => ListView.builder(
        itemBuilder: (context, index) => ListCategoryView(
          index: index,
          category: _listCategory[index],
          deleteFn: _deleteCategory,
        ),
        itemCount: _listCategory.length,
        physics: BouncingScrollPhysics(),
      );

  void onFloatingButtonTap(BuildContext context) {
    CommonMethod.navigateTo(context, AddCategoryPage(isEdit: false,),result: (value){
      if(value != null){
        // Category category = value;
        /*setState(() {
          _listCategory.add(category);
        });*/
        apiGetCategory();
      }
    });
  }

  void onRetry() {
    apiGetCategory();
  }

  void _deleteCategory(Category category)async{
    if (!await CommonMethod.isInternetConnected()) {
      CommonMethod.snackBarAlert(_scaffoldKey, 'No internet connectivity');
    } else {
      try{
        CommonMethod.showProgress(context, 'Deleting Category....');
        _firebaseFirestore = FirebaseFirestore.instance;
        await _firebaseFirestore.collection('Categories').doc(category.id).delete();
       /* setState(() {
          _listCategory.remove(category);
          print("isdeleteon=== > ${category.name}");
        });*/
        Navigator.pop(context);
        apiGetCategory();
      }catch (e){
        Navigator.pop(context);
        CommonMethod.snackBarAlert(_scaffoldKey, 'Error on deleting category');
        print('Error on deleting category ==> $e}');
      }
    }
  }

  void onRefreshTap() {
    apiGetCategory();
  }
}
