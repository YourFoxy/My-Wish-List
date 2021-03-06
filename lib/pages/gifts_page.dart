import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/pages/home_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/widgets/open_image.dart';
import 'package:video_player/video_player.dart';
import 'gift_adding_page.dart';

class GiftsPageWidget extends StatefulWidget {
  const GiftsPageWidget({Key? key}) : super(key: key);

  @override
  _GiftsPageWidgetState createState() => _GiftsPageWidgetState();
}

VideoPlayerController? videoController;
String str = 'sss';

class _GiftsPageWidgetState extends State<GiftsPageWidget> {
  AppBar appBar() {
    return AppBar(
      title: const Text(''),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageWidgets()),
          ),
        ),
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const GiftWidget(),
      floatingActionButton: userUid == fAuth.currentUser!.uid
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddGiftWidget()),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class GiftWidget extends StatefulWidget {
  const GiftWidget({Key? key}) : super(key: key);

  @override
  _GiftWidgetState createState() => _GiftWidgetState();
}

class _GiftWidgetState extends State<GiftWidget> {
  var pathImageFromvideo;
  BoxShadow shadow() {
    return BoxShadow(
      offset: const Offset(0, 17),
      blurRadius: 20,
      spreadRadius: -13,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _spaceForMediaImage(String mediaUrl) {
    var container = Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black26,
      ),
      child: AvatarView(
        radius: 30.0,
        avatarType: AvatarType.RECTANGLE,
        imagePath: mediaUrl,
        placeHolder: const Icon(
          Icons.circle_outlined,
          size: 50,
          color: Colors.white,
        ),
        errorWidget: const Icon(
          Icons.error,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
    return FractionallySizedBox(
      heightFactor: 1,
      child: container,
    );
  }

  Widget _spaceForMediaVideo() {
    var container = Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black26,
      ),
      child: Icon(
        Icons.video_collection_outlined,
        size: 40,
        color: Colors.white,
      ),
    );
    return FractionallySizedBox(
      heightFactor: 1,
      child: container,
    );
  }

  Widget giftName(String name) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.center,
        child: TextParameters(
          text: name,
          fontSize: 30.0,
        ),
      ),
    );
  }

  Widget removeContainer(Function() buttonRemove) {
    return userUid == fAuth.currentUser!.uid
        ? Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  buttonRemove();
                },
              ),
            ),
          )
        : SizedBox();
  }

  Widget _giftDescription(String description) {
    return FractionallySizedBox(
      widthFactor: 0.94,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextParameters(
              text: description,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget gift(Function() removeButton, bool isShow, Function() isShowFunc,
      String name, String description, String mediaUrl, bool isImage) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 200,
          child: Align(
            child: FractionallySizedBox(
              widthFactor: 0.94,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [shadow()],
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          if (isImage == false) {
                            videoController =
                                await VideoPlayerController.network(mediaUrl)
                                  ..initialize();
                            //  videoHeight = videoController!.value.size.height;
                            //videoController!.play();
                            setState(() {});
                          }

                          OpenImage().openImage(context, mediaUrl, isImage);
                        },
                        child: isImage
                            ? _spaceForMediaImage(mediaUrl)
                            : _spaceForMediaVideo(),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Stack(
                          children: [
                            giftName(name),
                            removeContainer(removeButton),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isShowFunc();
            });
          },
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
        ),
        if (isShow) _giftDescription(description),
      ],
    );
  }

  Widget showGifts() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(userUid)
            .doc('data')
            .collection('Categories')
            .doc(categoryUid)
            .collection('Gifts')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return ListView(
              children: snapshot.data!.docs.map((gifts) {
            Map<String, dynamic> data = gifts.data() as Map<String, dynamic>;

            return gift(
              () {
                gifts.reference.delete();
              },
              data['isShow'],
              () {
                updata(gifts.id, data['isShow']);
              },
              data['nameOfGift'],
              data['description'],
              data['mediaUrl'],
              data['isImage'],
            );
          }).toList());
        });
  }

  Future<void> updata(String id, bool isShow) {
    return FirebaseFirestore.instance
        .collection(userUid)
        .doc('data')
        .collection('Categories')
        .doc(categoryUid)
        .collection('Gifts')
        .doc(id)
        .update({'isShow': !isShow});
  }

  @override
  Widget build(BuildContext context) {
    return showGifts();
  }
}
