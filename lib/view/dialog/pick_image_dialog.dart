import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  onCameraTap(context);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                onGalleryTap(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.photo,
                    size: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Gallery'),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void onCameraTap(BuildContext context) async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    Navigator.of(context).pop(image);
  }

  void onGalleryTap(BuildContext context) async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Navigator.of(context).pop(image);
  }
}
