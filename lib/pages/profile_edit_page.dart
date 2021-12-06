import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wish_list/domain/user_profile_information.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/user_search_page.dart';
import 'package:wish_list/translation/locale_keys.g.dart';
import 'package:wish_list/widgets/place_for_picture.dart';
import 'package:wish_list/widgets/save_button_widget.dart';
import 'package:wish_list/widgets/text_field.dart';

TextEditingController userNicknameController = TextEditingController();
final TextEditingController userAgeController = TextEditingController();
final TextEditingController userCityController = TextEditingController();

List dataList = [];
late String imageUrl = '';

class SetDataProfileWidget extends StatefulWidget {
  bool isRu;
  SetDataProfileWidget({Key? key, required this.isRu}) : super(key: key);

  @override
  _SetDataProfileWidgetState createState() =>
      _SetDataProfileWidgetState(isRu: isRu);
}

class _SetDataProfileWidgetState extends State<SetDataProfileWidget> {
  bool isRu;
  String _nick = '';
  String _age = '';
  String _city = '';
  String _searchUser = '';
  @override
  void initState() {
    super.initState();
    userNicknameController.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {
      _nick = userNicknameController.text;
      _age = userAgeController.text;
      _city = userCityController.text;
    });
  }

  _SetDataProfileWidgetState({required this.isRu});
  Widget _profileInfoEdit() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PlaceForPictureWidget(),
          TextFieldWidget(
            fieldName: LocaleKeys.Nickname.tr(),
            controller: userNicknameController,
            maxLength: 20,
            maxLines: 1,
          ),
          TextFieldWidget(
            fieldName: LocaleKeys.Age.tr(),
            controller: userAgeController,
            maxLength: 20,
            maxLines: 1,
          ),
          TextFieldWidget(
            fieldName: LocaleKeys.City.tr(),
            controller: userCityController,
            maxLength: 20,
            maxLines: 1,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _saveData() {
    return SaveButtonWidget(
      func: () async {
        // if (_nick != '' &&
        //     _nick != ' '.toLowerCase() &&
        //     _age != '' &&
        //     _age != ' '.toLowerCase() &&
        //     _city != '' &&
        //     _city != ' '.toLowerCase()) {
        var str = '';
        if (imageProfileFile != null) {
          await FirebaseStorage.instance
              .ref()
              .child("users/${userUid}")
              .putFile(imageProfileFile!);
          str = await FirebaseStorage.instance
              .ref("users/${userUid}")
              .getDownloadURL();
        }
        UserProfileInformation.updateInformation(
            '${userNicknameController.text}',
            '${userAgeController.text}',
            '${userCityController.text}',
            str);
        imageProfileFile = null;
        str = '';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageWidgets()),
        );
        //}
        true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageWidgets()),
          ),
        ),
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: FlutterSwitch(
              width: 60.0,
              height: 30.0,
              valueFontSize: 15.0,
              toggleSize: 25.0,
              value: isRu,
              borderRadius: 20.0,
              padding: 8.0,
              activeColor: Colors.white60,
              inactiveColor: Colors.white60,
              toggleColor: Theme.of(context).primaryColor,
              activeTextColor: Theme.of(context).primaryColor,
              activeText: 'ru',
              inactiveTextColor: Theme.of(context).primaryColor,
              inactiveText: 'en',
              showOnOff: true,
              onToggle: (val) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isRu', val);

                isRu = prefs.getBool('isRu')!;
                setState(() {});
                isRu
                    ? await context.setLocale(Locale('ru'))
                    : await context.setLocale(Locale('en'));
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _profileInfoEdit(),
          _saveData(),
        ],
      ),
    );
  }
}
