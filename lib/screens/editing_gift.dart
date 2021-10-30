import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_container.dart';

class AddGiftWidget extends StatelessWidget {
  const AddGiftWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        // actions: _appBarMenuWidget(Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const SingleChildScrollView(
        child: GiftInformationWidget(),
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

  final _controller = TextEditingController();
  Widget description() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: TextField(
        controller: _controller,
        cursorColor: Theme.of(context).primaryColor,
        maxLength: 150,
        maxLines: 3,
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
