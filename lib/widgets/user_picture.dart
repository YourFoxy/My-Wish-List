import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';

class UserPicture extends StatelessWidget {
  String urlImage;
  UserPicture({Key? key, required this.urlImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Builder(builder: (context) {
        return AvatarView(
          radius: 30.0,
          avatarType: AvatarType.RECTANGLE,
          imagePath: urlImage,
          placeHolder: const Icon(
            Icons.circle_outlined,
            size: 50,
            color: Colors.white,
          ),
          errorWidget: const Icon(
            Icons.error,
            size: 50,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}
