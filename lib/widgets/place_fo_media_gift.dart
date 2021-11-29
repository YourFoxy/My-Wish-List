import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';

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
                            child: const TextParameters(
                              text: 'Image',
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
                            child: const TextParameters(
                              text: 'Video',
                              fontSize: 20.0,
                            ),
                            onPressed: () async {
                              isImage = false;
                              Navigator.pop(context);
                              var media = await ImagePicker()
                                  .pickVideo(source: ImageSource.gallery);
                              if (media == null) return;
                              mediaProfileFile = File(media.path);

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
            ? Image.file(
                media!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
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
