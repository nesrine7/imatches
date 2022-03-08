import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String? title;
  final String? phone;
  final String? birth;
  final String? mail;

  MyAlertDialog({
    this.title,
    this.phone,
    this.birth,
    this.mail

  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title.toString(),
      ),
      content:
      Container(
        height: 150,
      width: 400,
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(this.phone.toString()),

          Text(this.mail.toString()),
          Text(this.birth.toString()),
      ],
      )
      ),
      actions: [
        FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: Text('MODIFY'),
          color: Colors.lightGreen,
        ),
        FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: Text('DELETE'),
          color: Colors.lightGreen,
        ),
      ],

    );
  }
}