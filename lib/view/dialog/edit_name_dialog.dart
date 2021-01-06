import 'package:flutter/material.dart';
import 'package:wardrobe_2/model/category.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/view/ui/category_text_field.dart';

class EditCategoryDialog extends StatelessWidget {
  final String name;
  final String id;
  final _categoryNameController = TextEditingController();

   EditCategoryDialog({Key key, this.name,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _categoryNameController.text = name;
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryTextField(
              labelText: 'Category Name',
              controller: _categoryNameController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: FlatButton(onPressed: (){
                      Navigator.pop(context,null);
                    }, child: Text('Cancel'))),
                Expanded(
                    child: FlatButton(
                        onPressed: (){
                          Category c = Category();
                          Navigator.pop(context,_categoryNameController.text);
                        },
/*
                        color: MyColor.accent,
*/
                        child: Text(
                          'Update',
                          /*style: TextStyle(
                            color: Colors.white,
                          ),*/
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

}
