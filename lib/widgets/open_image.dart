import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wish_list/pages/gifts_page.dart';

double videoHeight = 300.0;

class OpenImage {
  void openImage(BuildContext context, String mediaUrl, bool isImage) {
    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: isImage ? true : false,
      //useRootNavigator: false,
      context: context,
      builder: (context) {
        return DialorForMedia(
          mediaUrl: mediaUrl,
          isImage: isImage,
        );
      },
    );
  }
}

class DialorForMedia extends StatefulWidget {
  String mediaUrl;
  bool isImage;
  DialorForMedia({Key? key, required this.mediaUrl, required this.isImage})
      : super(key: key);

  @override
  _DialorForMediaState createState() =>
      _DialorForMediaState(mediaUrl: mediaUrl, isImage: isImage);
}

class _DialorForMediaState extends State<DialorForMedia> {
  String mediaUrl;
  bool isImage;
  _DialorForMediaState({required this.mediaUrl, required this.isImage});

  Widget _placeForImage() {
    return SizedBox(
      height: 300,
      width: 300,
      child: AvatarView(
        radius: 30.0,
        avatarType: AvatarType.RECTANGLE,
        imagePath: mediaUrl,
      ),
    );
  }

  Widget _placeForVideo() {
    return InkWell(
      onTap: () {
        videoController!.value.isPlaying
            ? videoController!.pause()
            : videoController!.play();
        setState(() {});
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: VideoPlayer(
          videoController!,
        ),
      ),
    );
  }

  Widget _videoProgressIndicator() {
    return VideoProgressIndicator(
      videoController!,
      allowScrubbing: true,
      colors: VideoProgressColors(playedColor: Colors.white),
    );
  }

  Widget _buttonForVideo() {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              videoController!.seekTo(Duration(
                  seconds: videoController!.value.position.inSeconds - 3));
            },
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              videoController!.value.isPlaying
                  ? videoController!.pause()
                  : videoController!.play();
              setState(() {});
            },
            icon: Icon(
              videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              videoController!.seekTo(Duration(
                  seconds: videoController!.value.position.inSeconds + 3));
            },
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        //SingleChildScrollView(
        //child:
        WillPopScope(
      onWillPop: () async {
        videoController!.pause();
        Navigator.pop(context);
        return true;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        //Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 16,
        child: SizedBox(
          height: isImage ? 300 : double.infinity,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isImage ? _placeForImage() : _placeForVideo(),
              !isImage ? _videoProgressIndicator() : SizedBox(),
              !isImage ? _buttonForVideo() : SizedBox(),
            ],
          ),
        ),
        //),
      ),
    );
  }
}
