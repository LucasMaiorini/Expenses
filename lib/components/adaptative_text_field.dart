import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSubmitted;

  AdaptativeTextField(
      {this.label,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: this.controller,
              keyboardType: this.keyboardType,
              onSubmitted: this.onSubmitted,
              placeholder: this.label,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            ),
          )
        : TextField(
            keyboardType: this.keyboardType,
            onSubmitted: (_) => this.onSubmitted,
            controller: this.controller,
            decoration: InputDecoration(labelText: this.label),
          );
  }
}
