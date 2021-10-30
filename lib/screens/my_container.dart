import 'package:flutter/material.dart';
import 'package:wish_list/screens/text_parameters.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 100,
      // color: Colors.amber,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.72,
              widthFactor: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.topLeft,
            child: Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: const TextParameters(
                  text: 'dddddddddddddddddd', fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
