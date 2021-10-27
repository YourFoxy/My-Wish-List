import 'package:avatar_view/avatar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wish_list/screens/text_parameters.dart';

class GiftsPageWidget extends StatefulWidget {
  GiftsPageWidget({Key? key}) : super(key: key);

  @override
  _GiftsPageWidgetState createState() => _GiftsPageWidgetState();
}

CollectionReference myGifts = FirebaseFirestore.instance.collection('gifts');
bool b = false;

class _GiftsPageWidgetState extends State<GiftsPageWidget> {
  AppBar appBar() {
    return AppBar(
      title: Text(''),
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
      appBar: appBar(),
      body: StreamBuilder(
          stream: myGifts.orderBy('nameOfGift').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null)
              return Center(child: CircularProgressIndicator());
            return ListView(
                children: snapshot.data!.docs.map((gifts) {
              Map<String, dynamic> data = gifts.data() as Map<String, dynamic>;

              return GiftWidget(
                nameOfGift: data['nameOfGift'],
                description: data['description'],
                //removeButton: () {},
                // gifts.reference.delete(),
              );
            }).toList());
          }),
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
          AddGift(nameOfGift: 'qqq', description: 'sss').addGift();
          print('add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddGift {
  final String nameOfGift;
  final String description;
  final bool = false;
  AddGift({required this.nameOfGift, required this.description});

  Future<void> addGift() {
    return myGifts.add({
      'nameOfGift': nameOfGift,
      'description': description,
    });
  }
}

class GiftWidget extends StatefulWidget {
  final String nameOfGift;
  final String description;
  //final Function removeButton;
  GiftWidget({
    required this.nameOfGift,
    required this.description,
    //this.removeButton,
  });

  @override
  _GiftWidgetState createState() => _GiftWidgetState(
        nameOfGift,
        description,
        //removeButton,
      );
}

class _GiftWidgetState extends State<GiftWidget> {
  final String nameOfGift;
  final String description;
  //final Function removeButton;

  _GiftWidgetState(
    this.nameOfGift,
    this.description,
    //this.removeButton,
  );
  BoxShadow shadow() {
    return BoxShadow(
      offset: Offset(0, 17),
      blurRadius: 20,
      spreadRadius: -13,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget spaceForMedia() {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Container(
        width: 200,
        child: AvatarView(
          radius: 30.0,
          avatarType: AvatarType.RECTANGLE,
          imagePath:
              "https://sun9-11.userapi.com/impg/e3GSKLomqW9aEUnCMPqbeYo7LGY22IhfxwRQVA/rnT3cvaOe18.jpg?size=720x900&quality=96&sign=39226f38b88399db41020b178108ca01&type=album",
          placeHolder: Container(
            child: Icon(
              Icons.circle_outlined,
              size: 50,
              color: Colors.white,
            ),
          ),
          errorWidget: Container(
            child: Icon(
              Icons.error,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget giftName() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.center,
        child: TextParameters(
          text: nameOfGift,
          fontSize: 30.0,
        ),
      ),
    );
  }

  Widget removeContainer() {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _giftDescription() {
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

  Widget gift() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
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
                            giftName(),
                            removeContainer(),
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
              b = !b;
            });
          },
          icon: Icon(Icons.keyboard_arrow_down_sharp),
        ),
        if (b) _giftDescription(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return gift();
  }
}
