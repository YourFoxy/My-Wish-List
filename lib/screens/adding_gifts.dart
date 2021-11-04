import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/screens/home_page.dart';
import 'package:wish_list/screens/text_parameters.dart';
import 'package:wish_list/services/auth.dart';

import 'editing_gift.dart';

class GiftsPageWidget extends StatefulWidget {
  const GiftsPageWidget({Key? key}) : super(key: key);

  @override
  _GiftsPageWidgetState createState() => _GiftsPageWidgetState();
}

String str = 'sss';
//CollectionReference myGifts =
// FirebaseFirestore.instance.collection('${fAuth.currentUser!.uid} Gifts');
bool b = false;

class _GiftsPageWidgetState extends State<GiftsPageWidget> {
  AppBar appBar() {
    return AppBar(
      title: const Text(''),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        // ignore: deprecated_member_use
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
            MaterialPageRoute(builder: (context) => const HomePageWidgets()),
          ),
        ),
        title: const Text(''),
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const GiftWidget(),
      // body: StreamBuilder(
      //     stream: myGifts.orderBy('nameOfGift').snapshots(),
      //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (snapshot.data == null)
      //         return Center(child: CircularProgressIndicator());
      //       return ListView(
      //           children: snapshot.data!.docs.map((gifts) {
      //         Map<String, dynamic> data = gifts.data() as Map<String, dynamic>;

      //         return GiftWidget(
      //           nameOfGift: data['nameOfGift'],
      //           description: data['description'],
      //           //removeButton: () {
      //           //  print('object');
      //           //},
      //           removeButton: () {
      //             print('ddddqq');
      //             //myGifts.doc('${gifts.id}').delete();
      //             //myGifts.doc('$gifts.id').delete();
      //             //gifts.reference.delete();
      //             print(gifts.id);
      //             // myGifts.doc('$gifts').update({gifts.id: FieldValue.delete()});
      //           },
      //           id: gifts.id,
      //         );
      //       }).toList());
      //     }),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       GiftWidget(),
      //       GiftWidget(),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGiftWidget()),
          );
        },
        //  () {
        //   AddGift(nameOfGift: 'wwww', description: 'sss').addGift();
        //   print('add');
        // },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddGift {
  //final String nameOfGift;
  //final String description;
  final bool isShow = false;
  //final bool = false;
  // AddGift({required this.nameOfGift, required this.description});

  Future<void> addGift(String nameOfGift, String description) {
    return FirebaseFirestore.instance
        .collection('${fAuth.currentUser!.uid} Gifts')
        .add({
      'nameOfGift': nameOfGift,
      'description': description,
      'isShow': isShow,
      'category uid': categoryUid,
    });
  }
}

class GiftWidget extends StatefulWidget {
  const GiftWidget({Key? key}) : super(key: key);

  @override
  _GiftWidgetState createState() => _GiftWidgetState();
}

class _GiftWidgetState extends State<GiftWidget> {
  BoxShadow shadow() {
    return BoxShadow(
      offset: const Offset(0, 17),
      blurRadius: 20,
      spreadRadius: -13,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget spaceForMedia() {
    var container = const SizedBox(
      width: 200,
      child: AvatarView(
        radius: 30.0,
        avatarType: AvatarType.RECTANGLE,
        imagePath:
            "https://sun9-11.userapi.com/impg/e3GSKLomqW9aEUnCMPqbeYo7LGY22IhfxwRQVA/rnT3cvaOe18.jpg?size=720x900&quality=96&sign=39226f38b88399db41020b178108ca01&type=album",
        placeHolder: Icon(
          Icons.circle_outlined,
          size: 50,
          color: Colors.white,
        ),
        errorWidget: Icon(
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
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () => buttonRemove(),
        ),
      ),
    );
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
      String name, String description) {
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
                    Flexible(flex: 1, child: spaceForMedia()),
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
            .collection('${fAuth.currentUser!.uid} Gifts')
            .orderBy('nameOfGift')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
          return ListView(
              children: snapshot.data!.docs.map((gifts) {
            Map<String, dynamic> data = gifts.data() as Map<String, dynamic>;
            if (data['category uid'] == categoryUid) {
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
              );
            } else {
              return SizedBox();
            }
            // return gift(
            //   () {
            //     gifts.reference.delete();
            //   },
            //   data['isShow'],
            //   () {
            //     updata(gifts.id, data['isShow']);
            //   },
            //   data['nameOfGift'],
            //   data['description'],
            // );
          }).toList());
        });
  }

  Future<void> updata(String id, bool isShow) {
    // ignore: avoid_print
    print(id);
    return FirebaseFirestore.instance
        .collection('${fAuth.currentUser!.uid} Gifts')
        .doc(id)
        .update({'isShow': !isShow});
  }

  @override
  Widget build(BuildContext context) {
    return showGifts();
  }
}
