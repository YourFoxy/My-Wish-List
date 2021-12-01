import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wish_list/pages/gifts_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class PlaceForMediaWidget extends StatefulWidget {
  PlaceForMediaWidget({Key? key}) : super(key: key);

  @override
  _PlaceForMediaWidgetState createState() => _PlaceForMediaWidgetState();
}

File? mediaProfileFile;
bool isImage = false;

class _PlaceForMediaWidgetState extends State<PlaceForMediaWidget> {
  File? media;
  Widget _picture() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () async {
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
                  height: 200,
                  width: 240,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: FlatButton(
                            child: TextParameters(
                              text: LocaleKeys.Image.tr(),
                              fontSize: 20.0,
                            ),
                            onPressed: () async {
                              isImage = true;
                              Navigator.pop(context);

                              var media = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              if (media == null) return;
                              mediaProfileFile = File(media.path);

                              setState(() {
                                this.media = mediaProfileFile;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                        width: 230,
                        color: Colors.black26,
                      ),
                      Flexible(
                        child: Center(
                          child: FlatButton(
                            child: TextParameters(
                              text: LocaleKeys.Video.tr(),
                              fontSize: 20.0,
                            ),
                            onPressed: () async {
                              isImage = false;
                              Navigator.pop(context);
                              var media = await ImagePicker()
                                  .pickVideo(source: ImageSource.gallery);
                              if (media == null) return;
                              mediaProfileFile = File(media.path);
                              // print('FIIIIIILEEEEEE ${media.path}');
                              videoController =
                                  VideoPlayerController.network('${media.path}')
                                    ..initialize();

                              videoController!.play();
                              videoController?.setVolume(0);
                              videoController!.setLooping(true);
                              setState(() {
                                this.media = mediaProfileFile;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: media != null
            ? isImage
                ? Image.file(
                    media!,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : AspectRatio(
                    aspectRatio: videoController!.value.aspectRatio,
                    child: VideoPlayer(videoController!),
                  )
            : Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 50.0,
              ),
      ),
    );
  }

  // Widget _buildMedia(BuildContext context) {
  //   return FutureBuilder<DocumentSnapshot>(
  //       future: FirebaseFirestore.instance
  //           .collection('Users')
  //           .doc(fAuth.currentUser!.uid)
  //           .get(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return const TextParameters(text: '', fontSize: 20.0);
  //         }
  //         var userDocument = snapshot.data;
  //         var type = NetworkImage(userDocument?['userImageUrl']).runtimeType;
  //         print('TTTTYYYYYYYYPEEEE ${type}');
  //         return Image(
  //             image: NetworkImage(userDocument?['userImageUrl']),
  //             height: 300,
  //             width: double.infinity,
  //             fit: BoxFit.cover);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return _picture();
  }
}
