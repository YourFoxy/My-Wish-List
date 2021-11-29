import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';

class OpenImage {
  void openImage(BuildContext context, String imageUrl) {
    showDialog(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 16,
              child: SizedBox(
                height: 300,
                width: 300,
                child: AvatarView(
                  radius: 30.0,
                  avatarType: AvatarType.RECTANGLE,
                  imagePath: imageUrl,
                ),
              ));
        });
  }
}
