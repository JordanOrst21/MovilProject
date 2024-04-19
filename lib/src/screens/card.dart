import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget tittle;
  final Widget icon;

  MyCard({required this.tittle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[this.tittle, this.icon],
          )),
    );
  }
}
