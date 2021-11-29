import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wish_list/pages/gifts_page.dart';

class OpenImage {
  void openImage(BuildContext context, String mediaUrl, bool isImage) {
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
                height: 300,
                width: 300,
                child: isImage
                    ? AvatarView(
                        radius: 30.0,
                        avatarType: AvatarType.RECTANGLE,
                        imagePath: mediaUrl,
                      )
                    : InkWell(
                        onTap: () {
                          //  print('VVVPPPPPPPPP ${urlVideo}');
                          videoController!.value.isPlaying
                              ? videoController!.pause()
                              : videoController!.play();

                          print(
                              'CCCCCCCCCCCCCOOOOOOOOONNNNNN ${videoController}');
                        },
                        child: AspectRatio(
                          aspectRatio: videoController!.value.aspectRatio,
                          child: VideoPlayer(
                            videoController!,
                          ),
                        ),
                      ),
              ));
        });
  }
}
