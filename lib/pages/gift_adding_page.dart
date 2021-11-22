import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish_list/domain/user_gifts.dart';
import 'package:wish_list/domain/user_profile_information.dart';
import 'package:wish_list/pages/gifts_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/place_for_picture.dart';
import 'package:wish_list/widgets/save_button_widget.dart';
import 'package:wish_list/widgets/text_field.dart';

final _nameController = TextEditingController();
final _descriptionController = TextEditingController();

class AddGiftWidget extends StatelessWidget {
  const AddGiftWidget({Key? key}) : super(key: key);
  void _addGift(BuildContext context) async {
    if (imageProfileFile != null &&
        _nameController.text != '' &&
        _descriptionController.text != '') {
      await FirebaseStorage.instance
          .ref()
          .child("user/r/${fAuth.currentUser!.uid}")
          .putFile(imageProfileFile!);

      var imageUrl = await FirebaseStorage.instance
          .ref("user/r/${fAuth.currentUser!.uid}")
          .getDownloadURL();
      AddGift()
          .addGift(_nameController.text, _descriptionController.text, imageUrl);
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
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          const SingleChildScrollView(
            child: GiftInformationWidget(),
          ),
          SafeArea(
            child: SaveButtonWidget(
              func: () {
                _addGift(context);
              },
            ),
            // child: Align(
            //   alignment: Alignment.bottomCenter,
            //   child: InkWell(
            //     onTap: () {
            //       if (_nameController.text != '' &&
            //           _descriptionController.text != '') {
            //         AddGift(
            //                 //nameOfGift: _nameController.text,
            //                 //description: _descriptionController.text,
            //                 )
            //             .addGift(
            //                 _nameController.text, _descriptionController.text);
            //         _nameController.text = '';
            //         _descriptionController.text = '';
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => GiftsPageWidget()),
            //         );
            //       }
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       width: double.infinity,
            //       height: 50,
            //       color: Theme.of(context).primaryColor,
            //       child: const TextParameters(
            //         text: 'SAVE',
            //         fontSize: 20.0,
            //       ),
            //     ),
            //   ),
            // ),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PlaceForPictureWidget(),
        const SizedBox(
          height: 20,
        ),
        TextFieldWidget(
          fieldName: 'Name',
          controller: _nameController,
          maxLength: 20,
          maxLines: 1,
        ),
        TextFieldWidget(
          fieldName: 'Description',
          controller: _descriptionController,
          maxLength: 150,
          maxLines: 2,
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
