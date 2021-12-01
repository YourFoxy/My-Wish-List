import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/user_search_page.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class SearchBarWidget extends StatelessWidget {
//  TextEditingController userNicknameController;
  SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            //width: 100,
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 0.0,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                hintText: LocaleKeys.Search.tr(),
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
