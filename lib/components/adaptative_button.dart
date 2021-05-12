import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            onPressed: (onPressed),
            child: Text(
              label,
              // style: TextStyle(color: Colors.purple[600]),
            ),
            style: TextButton.styleFrom(
              primary: Theme.of(context).textTheme.button.color,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
  }
}
