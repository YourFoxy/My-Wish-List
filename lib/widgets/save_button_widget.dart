import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class SaveButtonWidget extends StatelessWidget {
  final Function func;
  const SaveButtonWidget({required this.func});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black54,
                context: context,
                builder: (context) {
                  return Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                });
            func();
          },
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
            child: TextParameters(
              text: LocaleKeys.SAVE.tr(),
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
