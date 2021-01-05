import 'package:flutter/material.dart';
import 'package:wardrobe_2/style/colors.dart';
import 'package:wardrobe_2/style/images.dart';

// ignore: must_be_immutable
class MessageUi extends StatelessWidget {
  String image;
  String title;
  String subTitle;
  Function onRetry;

  MessageUi.noInternet({Function onRetry}) {
    this.image = MyImages.noInternet;
    this.title = 'No Internet';
    this.subTitle =
        'Your internet connection is not on or your connection might be slow';
    this.onRetry = onRetry;
  }

  MessageUi.noData() {
    this.image = MyImages.noData;
    this.title = 'No Category';
    this.subTitle = 'There is no category in wardrobe';
  }

  MessageUi.wentWrong({Function onRetry}) {
    this.image = MyImages.noData;
    this.title = 'Error';
    this.subTitle = 'Something went wrong try again later';
    this.onRetry = onRetry;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColor.text, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColor.text, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: onRetry == null ? false : true,
            child: FlatButton(
                onPressed: onRetry, color: MyColor.accent, child: Text('Retry')),
          )
        ],
      ),
    );
  }
}
