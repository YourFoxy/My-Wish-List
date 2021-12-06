import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/domain/user_gifts.dart';
import 'package:wish_list/pages/gifts_page.dart';
import 'package:wish_list/translation/locale_keys.g.dart';
import 'package:wish_list/widgets/place_fo_media_gift.dart';
import 'package:wish_list/widgets/save_button_widget.dart';
import 'package:wish_list/widgets/text_field.dart';

final giftNameController = TextEditingController();
final giftDescriptionController = TextEditingController();
bool isLoad = false;

class AddGiftWidget extends StatefulWidget {
  AddGiftWidget({Key? key}) : super(key: key);

  @override
  _AddGiftWidgetState createState() => _AddGiftWidgetState();
}

class _AddGiftWidgetState extends State<AddGiftWidget> {
  Future<void> _addGift(BuildContext context) async {
    if (mediaProfileFile != null &&
        giftNameController.text.toLowerCase() != '' &&
        giftDescriptionController.text.toLowerCase() != '') {
      await FirebaseStorage.instance
          .ref()
          .child("user/r/${mediaProfileFile!.hashCode}")
          .putFile(mediaProfileFile!);

      var mediaUrl = await FirebaseStorage.instance
          .ref("user/r/${mediaProfileFile!.hashCode}")
          .getDownloadURL();

      AddGift().addGift(giftNameController.text, giftDescriptionController.text,
          mediaUrl, isImage);

      mediaProfileFile = null;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GiftsPageWidget()),
      );
    } else if (mediaProfileFile == null &&
        giftNameController.text.toLowerCase() != '' &&
        giftDescriptionController.text.toLowerCase() != '') {
      var mediaUrl = 'images/FoxyTask.png';

      AddGift().addGift(giftNameController.text, giftDescriptionController.text,
          mediaUrl, isImage);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GiftsPageWidget()),
      );
    } else
      null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GiftsPageWidget()),
          ),
        ),
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          const SingleChildScrollView(
            child: GiftInformationWidget(),
          ),
          SafeArea(
            child: SaveButtonWidget(
              func: () async {
                await _addGift(context);

                giftNameController.clear();
                giftDescriptionController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GiftInformationWidget extends StatefulWidget {
  const GiftInformationWidget({Key? key}) : super(key: key);

  @override
  _GiftInformationWidgetState createState() => _GiftInformationWidgetState();
}

class _GiftInformationWidgetState extends State<GiftInformationWidget> {
  Widget _nameField() {
    return TextFieldWidget(
      fieldName: LocaleKeys.Name.tr(),
      controller: giftNameController,
      maxLength: 20,
      maxLines: 1,
    );
  }

  Widget _descriptionField() {
    return TextFieldWidget(
      fieldName: LocaleKeys.Description.tr(),
      controller: giftDescriptionController,
      maxLength: 150,
      maxLines: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaceForMediaWidget(),
        const SizedBox(
          height: 20,
        ),
        _nameField(),
        _descriptionField(),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
