import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wish_list/main.dart';
import 'package:wish_list/pages/auth.dart';
import 'package:wish_list/pages/friends.dart';
import 'package:wish_list/pages/profile_edit_page.dart';
import 'package:wish_list/pages/text_parameters.dart';
import 'package:wish_list/pages/user_search_page.dart';
import 'package:wish_list/services/auth.dart';
import 'package:wish_list/translation/codegen_loader.g.dart';
import 'package:wish_list/translation/locale_keys.g.dart';
import 'package:wish_list/widgets/search_bar.dart';
import 'package:wish_list/widgets/search_or_fiends_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'gifts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:wish_list/services/auth.dart';

class HomePageWidgets extends StatefulWidget {
  HomePageWidgets({Key? key}) : super(key: key);

  @override
  _HomePageWidgetsState createState() => _HomePageWidgetsState();
}

late String userUid = fAuth.currentUser!.uid;
int r = 0;
late String categoryUid;
//CollectionReference myR =
// FirebaseFirestore.instance.collection(fAuth.currentUser!.uid);
//bool isRu = true;

class _HomePageWidgetsState extends State<HomePageWidgets> {
  // List<Widget> _appBarMenuWidget(Color color) {
  //   return <Widget>[
  //     PopupMenuButton(
  //       color: color,
  //       itemBuilder: (BuildContext bc) => [
  //         const PopupMenuItem(
  //             child: Text("Edit profile"), value: "Edit profile"),
  //         const PopupMenuItem(child: Text("Exit"), value: "Exit"),
  //       ],
  //       onSelected: (route) {
  //         if (route == 'Edit profile') {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => SetDataProfileWidget()),
  //           );
  //         } else if (route == 'Exit') {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => const AuthorizationPage()),
  //           );
  //         }
  //       },
  //     ),
  //   ];
  // }

  Widget _bottomMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: userUid == fAuth.currentUser!.uid
            ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        bool isRu = prefs.getBool('isRu')!;
                        userNicknameController.text = prefs
                            .getString('${fAuth.currentUser!.uid} Nickname')!;
                        // prefs.setString('d', 'd');
                        userAgeController.text =
                            prefs.getString('${fAuth.currentUser!.uid} Age')!;
                        userCityController.text =
                            prefs.getString('${fAuth.currentUser!.uid} City')!;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetDataProfileWidget(
                                    isRu: isRu,
                                  )),
                        );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        AuthService().logOut();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthorizationPage()),
                        );
                      },
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        userUid = fAuth.currentUser!.uid;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageWidgets()),
                        );
                      },
                      icon: Icon(Icons.home),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
    // BottomNavigationBar(
    //   backgroundColor: Theme.of(context).primaryColor,
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: '',
    //     ),
    //     // BottomNavigationBarItem(
    //     //   icon: Icon(Icons.add_outlined),
    //     //   label: 'sss',
    //     // ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.menu),
    //       label: '',
    //     ),
    //   ],
    //   selectedItemColor: Colors.white,
    //   onTap: (int i) {},
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        // actions: <Widget>[

        // ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      extendBody: true,
      floatingActionButtonLocation: userUid == fAuth.currentUser!.uid
          ? FloatingActionButtonLocation.centerDocked
          : null,
      floatingActionButton: userUid == fAuth.currentUser!.uid
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                print(
                    '........................ ${userUid} ;;; ${fAuth.currentUser!.uid}');
                showDialog(
                    barrierColor: Colors.black54,
                    context: context,
                    builder: (context) {
                      return const AddingCategoryWidget();
                    });
              },
              // AddingCategory().add(context),
              //AddingCategory(context: context).add(),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: _bottomMenu(),
      body: Column(
        children: const <Widget>[
          _PersonalInformation(),
          CategoryWidget2(),
        ],
      ),
    );
  }
}

class AddingCategory {
  //final BuildContext context;

  // AddingCategory({
  //   required this.context,
  // });

  void add(BuildContext context) {
    showDialog(
        barrierColor: Colors.black54,
        context: context,
        builder: (context) {
          return const AddingCategoryWidget();
        });
  }
}

class AddingCategoryWidget extends StatefulWidget {
  const AddingCategoryWidget({Key? key}) : super(key: key);

  @override
  _AddingCategoryWidgetState createState() => _AddingCategoryWidgetState();
}

class _AddingCategoryWidgetState extends State<AddingCategoryWidget> {
  final TextEditingController _controller = TextEditingController();

  Widget _actionText() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Align(
          alignment: Alignment.topCenter,
          child: TextParameters(
            text: LocaleKeys.creating_a_category.tr(),
            fontSize: Localizations.localeOf(context).toLanguageTag() == 'ru'
                ? 25.0
                : 30.0,
          )),
    );
  }

  Widget _inputField() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 250,
        child: TextField(
          autofocus: true,
          controller: _controller,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Localizations.localeOf(context).toLanguageTag() == 'ru'
                  ? 15
                  : 20,
              color: Colors.white30,
            ),
            hintText: LocaleKeys.Name_of_new_category.tr(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    if (_controller.text != '') {
      FirebaseFirestore.instance
          .collection(userUid)
          .doc('data')
          .collection('Categories')
          .add({'name of categoty': _controller.text});
      _controller.text = '';
      Navigator.pop(context);
    }
  }

  Widget _allButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            _button(LocaleKeys.CANCEL.tr(), () {
              Navigator.pop(context);
            }),
            Container(
              width: 3,
              height: 20,
              color: Colors.white,
            ),
            _button(LocaleKeys.SAVE.tr(), add),
          ],
        ),
      ),
    );
  }

  Widget _button(String buttonType, Function() buttonFunction) {
    return Flexible(
      //flex: 1,
      child: Center(
        // ignore: deprecated_member_use
        child: FlatButton(
          child: TextParameters(
            text: buttonType,
            fontSize: Localizations.localeOf(context).toLanguageTag() == 'ru'
                ? 15.0
                : 20.0,
          ),
          onPressed: () => buttonFunction(),
        ),
      ),
    );
  }

  Widget _addWindow() {
    return SizedBox(
      height: 200,
      width: 240,
      child: Column(
        children: <Widget>[
          _actionText(),
          _inputField(),
          _allButtons(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 16,
      child: _addWindow(),
    );
  }
}

class _PersonalInformation extends StatefulWidget {
  const _PersonalInformation({Key? key}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<_PersonalInformation> {
  Widget _userPicture(String url) {
    //print('HJGUYGFYTDRTRDYFVJHGIU $url');
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FractionallySizedBox(
          child: CircleAvatar(
            //minRadius: 20,
            radius: 70,
            backgroundImage: NetworkImage(url),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  // Widget _searchBar() {
  //   return FractionallySizedBox(
  //     widthFactor: .64,
  //     child: Container(
  //       //width: 100,
  //       margin: const EdgeInsets.symmetric(
  //         vertical: 5.0,
  //         horizontal: 10.0,
  //       ),
  //       padding: const EdgeInsets.symmetric(
  //         vertical: 5.0,
  //         horizontal: 20.0,
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       child: TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Search',
  //           icon: Icon(
  //             Icons.search,
  //             color: Theme.of(context).primaryColor,
  //           ),
  //           border: InputBorder.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildImage(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Users').doc(userUid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;
          print('UUUUUUUUUUUUUUUUU 2 ${userDocument?['userImageUrl']}');
          return _userPicture(userDocument?['userImageUrl']);
        });
  }

  Widget _buildName(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Users').doc(userUid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;
          return _userName('${userDocument?['userNicknameController']}');
        });
  }

  Widget _userName(String str) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextParameters(
        text: str,
        fontSize: 30.0,
      ),
    );
  }

  Widget _buildAgeAndCity(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('Users').doc(userUid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const TextParameters(text: '', fontSize: 20.0);
          }
          var userDocument = snapshot.data;
          return _userInfofmation(
              '${LocaleKeys.Age.tr()}: ${userDocument?['userAgeController']}',
              '${LocaleKeys.City.tr()}: ${userDocument?['userCityController']}');
        });
  }

  Widget _userInfofmation(String age, String city) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextParameters(
            text: age,
            fontSize: 20.0,
          ),
          TextParameters(
            text: city,
            fontSize: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _userTextInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildName(context),
        // _userName(),
        //_userInfofmation(age, city),
        _buildAgeAndCity(context),
        //  SearchBarWidget(),
        //_userInfofmation(),
      ],
    );
  }

  Widget _blockWithInformation(String age, String city) {
    return SingleChildScrollView(
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
        child: Stack(
          children: <Widget>[
            _userTextInformation(),
            _buildImage(context),
            userUid == fAuth.currentUser!.uid
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          SearchOrFriendsButtonWidget(
                            icon: Icons.search,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserSearch()),
                              );
                            },
                          ),
                          SearchOrFriendsButtonWidget(
                            icon: Icons.person,
                            func: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendsPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  // Widget _blockWithInformation2() {
  //   return FutureBuilder(
  //       future: futureSearchResults, builder: (context, dataSnapshot) {
  //         if(!dataSnapshot.hasData){
  //           return circularProgress();
  //         }

  //         //This part is also not working properly
  //         List<UserResult> searchUserResult = [];
  //         dataSnapshot.data.docs.forEach((document){
  //           Users users = Users.fromDocument(document);
  //           UserResult userResult = UserResult(users);
  //           searchUserResult.add(userResult);
  //         });
  //         return ListView(children: searchUserResult,);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return _blockWithInformation('df', 'dff');
  }
}
// class GetUserInformation {

//   Future<void> addGift() {
//     String name = FirebaseFirestore.instance
//             .collection('${fAuth.currentUser!.uid} Profile information').doc('dd').get('dd').toString();
//   }
// }
class CategoryWidget2 extends StatefulWidget {
  const CategoryWidget2({Key? key}) : super(key: key);

  @override
  _CategoryWidget2State createState() => _CategoryWidget2State();
}

class _CategoryWidget2State extends State<CategoryWidget2> {
  Widget _nameCategory(String str) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextParameters(
          text: str,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget _removeCategory(Function() buttonRemove) {
    return userUid == fAuth.currentUser!.uid
        ? Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FractionallySizedBox(
                heightFactor: .2,
                widthFactor: .2,
                child: InkWell(
                  onTap: () {
                    buttonRemove();
                    // FirebaseFirestore.instance
                    //     .collection(fAuth.currentUser!.uid)
                    //     .doc('data')
                    //     .collection('Categories')
                    //     .doc(categoryUid)
                    //     .delete();

                    // FirebaseFirestore.instance
                    //     .collection('${fAuth.currentUser!.uid} Gifts')
                    //     .get()
                    //     .then((querySnapshot) {
                    //   querySnapshot.docs.forEach((document) {
                    //     FirebaseFirestore.instance.batch().delete(document.reference);
                    //   });
                    //   return FirebaseFirestore.instance.batch().commit();
                    // });
                  },
                  child: const Icon(
                    Icons.disabled_by_default_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget _designCategory(String str, String id) {
    return InkWell(
      onTap: () {
        categoryUid = id;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GiftsPageWidget()),
        );
      },
      child: SizedBox(
        height: 180,
        width: 200,
        child: FractionallySizedBox(
          heightFactor: 1,
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 17),
                  blurRadius: 20,
                  spreadRadius: -13,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            child: _nameCategory(str),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(userUid)
            .doc('data')
            .collection('Categories')
            .orderBy('name of categoty')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) return const CircularProgressIndicator();
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: snapshot.data!.docs.map((my) {
                  return SizedBox(
                    height: 180,
                    width: 200,
                    child: Stack(children: [
                      _designCategory(my['name of categoty'], my.id),
                      _removeCategory(() {
                        my.reference.delete();
                      }),
                    ]),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _category();
  }
}
