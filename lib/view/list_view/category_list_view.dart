import 'package:flutter/material.dart';
import 'package:wardrobe_2/model/category.dart';
import 'package:wardrobe_2/util/methods.dart';
import 'package:wardrobe_2/view/page/add_category_page.dart';

import 'sub_category_list_view.dart';

class ListCategoryView extends StatelessWidget {
  final int index;
  final Category category;
  final Function deleteFn;
  final Function editFn;
  final List<String> _menuList = ['Edit', 'Delete'];

  ListCategoryView({Key key, this.index,this.category,this.deleteFn,this.editFn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: index == 9 ? 80 : 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return _menuList
                        .map((e) => PopupMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList();
                  },
                  onSelected: (value) {
                    onMenuSelect(value,context);
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: category.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SubcategoryListView(
                index: index,
                imgUrl: category.images[index],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onMenuSelect(value, BuildContext context) {
    if(value == 'Edit'){
      CommonMethod.navigateTo(context, AddCategoryPage(
        isEdit: true,
        category: category,
      ));
    }else{
      deleteFn(category);
    }
  }
}
