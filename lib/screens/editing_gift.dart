import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wish_list/screens/adding_gifts.dart';
import 'package:wish_list/screens/text_parameters.dart';

import 'my_container.dart';

final _nameController = TextEditingController();
final _descriptionController = TextEditingController();

class AddGiftWidget extends StatelessWidget {
  const AddGiftWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GiftsPageWidget()),
          ),
        ),
        title: const Text(''),
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          const SingleChildScrollView(
            child: GiftInformationWidget(),
          ),
          SafeArea(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                if (_nameController.text != '' &&
                    _descriptionController.text != '') {
                  AddGift(
                          //nameOfGift: _nameController.text,
                          //description: _descriptionController.text,
                          )
                      .addGift(
                          _nameController.text, _descriptionController.text);
                  _nameController.text = '';
                  _descriptionController.text = '';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GiftsPageWidget()),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                color: Theme.of(context).primaryColor,
                child: const TextParameters(
                  text: 'SAVE',
                  fontSize: 20.0,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class GiftInformationWidget extends StatefulWidget {
  const GiftInformationWidget({Key? key}) : super(key: key);

  @override
  _GiftInformationWidgetState createState() => _GiftInformationWidgetState();
}

class _GiftInformationWidgetState extends State<GiftInformationWidget> {
  Widget _spaceForMedia() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget name() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        controller: _nameController,
        maxLength: 20,
        cursorColor: Theme.of(context).primaryColor,
        style: GoogleFonts.crimsonText(
          color: Theme.of(context).primaryColor,
          //textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          //fillColor: Colors.amber,
          labelText: 'Name',
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        controller: _descriptionController,
        cursorColor: Theme.of(context).primaryColor,
        maxLength: 150,
        maxLines: 2,
        textCapitalization: TextCapitalization.sentences,
        style: GoogleFonts.crimsonText(
          color: Theme.of(context).primaryColor,
          //textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          //counterText: '${this._controller.text.split(' ').length}  words',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          //fillColor: Colors.amber,
          labelText: 'Description',
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        // onChanged: (text) => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _spaceForMedia(),
        name(),
        description(),
      ],
    );
  }
}
