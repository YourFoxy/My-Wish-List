import 'package:flutter/material.dart';
import 'package:wish_list/pages/text_parameters.dart';

class SaveButtonWidget extends StatelessWidget {
  final Function func;
  const SaveButtonWidget({required this.func});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () => func(),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
            child: const TextParameters(
              text: 'SAVE',
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
