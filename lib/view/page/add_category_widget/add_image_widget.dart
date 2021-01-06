import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/view/dialog/pick_image_dialog.dart';
import 'package:wardrobe_2/view/list_view/add_category_image_view.dart';

class AddCategoryImageWidget extends StatefulWidget {

   List<Map<String,Object>> imgMap;
   AddCategoryImageWidget({Key key, this.imgMap}) : super(key: key);
   
  @override
  _AddCategoryImageWidgetState createState() => _AddCategoryImageWidgetState();
}

class _AddCategoryImageWidgetState extends State<AddCategoryImageWidget> {
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
          margin: EdgeInsets.only(top: 20, bottom: 50),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child:
          widget.imgMap.length == 0 ? InkWell(
                  onTap: (){
                    openPickerDialog(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Add Images',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          children: [
                            TextSpan(
                            text: '\nof your outfits',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                            )
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(Icons.photo_library_outlined,size: 70,color: Colors.black54,)
                    ],
                  ),
                ): Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        childAspectRatio: 0.75),
                    itemCount: widget.imgMap.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddCategoryImageView(
                        map: widget.imgMap[index],
                        onImageTap: onImageTap,
                      );
                    }),
              ),
              FlatButton(
                  onPressed: () {
                  ! _isSelect ? openPickerDialog(context) : _removeSelectedImages();
                  },
                  height: 10,
                  color: MyColor.accent,
                  child: Text(_isSelect ? 'Remove':'Add')),
            ],
          )),
    );
  }

  void openPickerDialog(BuildContext context) {
    showDialog(context: context,child: PickImageDialog()).then((value){
      if(value != null){
        PickedFile pickedFile = value;
        setState(() {
          var map = {
            'image':pickedFile.path,
            'isSelect': false,
          };
          widget.imgMap.add(map);
        });
      }
    });
  }
  void onImageTap(){
    for(int i = 0 ;i < widget.imgMap.length; i++){
      if(widget.imgMap[i]['isSelect']){
        setState(() {
          _isSelect = true;
        });
        return;
      }else{
        setState(() {
          _isSelect = false;
        });
      }
    }
  }
  void _removeSelectedImages(){
      setState(() {
        widget.imgMap.removeWhere((value) => value['isSelect'] == true);
        _isSelect = false;
      });
  }
}
