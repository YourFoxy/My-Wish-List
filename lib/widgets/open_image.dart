import 'dart:ffi';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wish_list/pages/gifts_page.dart';

class OpenImage {
  void openImage(BuildContext context, String mediaUrl, bool isImage) {
    showDialog(
      barrierColor: Colors.black54,
      useRootNavigator: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: SizedBox(
            height: isImage ? 300 : 340,
            width: 300,
            child: Column(
              children: [
                isImage
                    ? SizedBox(
                        height: 300,
                        width: 300,
                        child: AvatarView(
                          radius: 30.0,
                          avatarType: AvatarType.RECTANGLE,
                          imagePath: mediaUrl,
                        ),
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
                !isImage
                    ? VideoProgressIndicator(
                        videoController!,
                        allowScrubbing: true,
                        colors: VideoProgressColors(playedColor: Colors.white),
                      )
                    : SizedBox(),
                !isImage
                    ? Container(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
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
                              },
                              icon: Icon(
                                videoController!.value.isPlaying
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
