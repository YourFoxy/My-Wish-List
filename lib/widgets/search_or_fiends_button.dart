import 'package:flutter/material.dart';

class SearchOrFriendsButtonWidget extends StatelessWidget {
  Function func;
  IconData? icon;
  SearchOrFriendsButtonWidget({
    Key? key,
    required this.icon,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            func();
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFFCBD1CF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}
