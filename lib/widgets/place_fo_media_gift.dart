import 'dart:io';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wish_list/pages/gifts_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/translation/locale_keys.g.dart';

class PlaceForMediaWidget extends StatefulWidget {
  PlaceForMediaWidget({Key? key}) : super(key: key);

  @override
  _PlaceForMediaWidgetState createState() => _PlaceForMediaWidgetState();
}

File? mediaProfileFile;
bool isImage = false;

class _PlaceForMediaWidgetState extends State<PlaceForMediaWidget> {
  void _getImage() async {
    isImage = true;
    Navigator.pop(context);

    var media = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (media == null) return;
    mediaProfileFile = File(media.path);

    setState(() {
      this.media = mediaProfileFile;
    });
  }

  void _getVideo() async {
    isImage = false;
    Navigator.pop(context);
    var media = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (media == null) return;
    mediaProfileFile = File(media.path);
    videoController = VideoPlayerController.network('${media.path}')
      ..initialize();

    videoController!.play();
    videoController?.setVolume(0);
    videoController!.setLooping(true);
    setState(() {
      this.media = mediaProfileFile;
    });
  }

  Widget _imageButton() {
    return Flexible(
      child: Center(
        child: FlatButton(
          child: TextParameters(
            text: LocaleKeys.Image.tr(),
            fontSize: 20.0,
          ),
          onPressed: () => _getImage(),
        ),
      ),
    );
  }

  Widget _videoButton() {
    return Flexible(
      child: Center(
        child: FlatButton(
          child: TextParameters(
            text: LocaleKeys.Video.tr(),
            fontSize: 20.0,
          ),
          onPressed: () => _getVideo(),
        ),
      ),
    );
  }

  Widget _setImage() {
    return Image.file(
      media!,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget _setVideo() {
    return AspectRatio(
      aspectRatio: videoController!.value.aspectRatio,
      child: VideoPlayer(videoController!),
    );
  }

  Future<dynamic> _dialogWindow() {
    return showDialog(
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: SizedBox(
            height: 200,
            width: 240,
            child: Column(
              children: <Widget>[
                _imageButton(),
                Container(
                  height: 3,
                  width: 230,
                  color: Colors.black26,
                ),
                _videoButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  File? media;
  Widget _media() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () async {
          _dialogWindow();
        },
        child: media != null
            ? isImage
                ? _setImage()
                : _setVideo()
            : const Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 50.0,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _media();
  }
}
