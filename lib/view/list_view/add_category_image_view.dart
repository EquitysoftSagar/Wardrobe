import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/style/images.dart';

class AddCategoryImageView extends StatefulWidget {
  final Map<String, Object> map;
  final Function onImageTap;

  const AddCategoryImageView({Key key, this.map, this.onImageTap})
      : super(key: key);

  @override
  _AddCategoryImageViewState createState() => _AddCategoryImageViewState();
}

class _AddCategoryImageViewState extends State<AddCategoryImageView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.map['isSelect'] = !widget.map['isSelect'];
          widget.onImageTap();
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(fit: StackFit.expand, children: [
          widget.map['isLink'] == false
              ? Image.file(
                  File(widget.map['image']),
                  height: 100,
                  width: 70,
                  fit: BoxFit.cover,
                )
              : FadeInImage.assetNetwork(
                  placeholder: MyImages.wardrobe,
                  image: widget.map['image'],
                  height: 100,
                  width: 70,
                  fit: BoxFit.cover,
                ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  !widget.map['isSelect']
                      ? Icons.radio_button_unchecked
                      : Icons.check_circle,
                  color: MyColor.primary,
                ),
              ))
        ]),
      ),
    );
  }
}
