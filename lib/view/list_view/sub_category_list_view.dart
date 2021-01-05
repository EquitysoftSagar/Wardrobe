import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/style/images.dart';

class SubcategoryListView extends StatelessWidget {
  final int index;
  final String imgUrl;

  const SubcategoryListView({Key key, this.index,this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 5,bottom: 5, left: index == 0 ? 15 : 0, right: 15),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: MyColor.shadow, blurRadius: 1)]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: /*Image.asset(
          MyImages.outfit,
          width: 100,
          fit: BoxFit.cover,
        ),*/
        FadeInImage.assetNetwork(
          image: imgUrl,
          width: 120,
          fit: BoxFit.cover,
          placeholder: MyImages.wardrobe,
        )
      ),
    );
  }
}
