import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function dateHandler;

  const AdaptiveButton(this.text, this.dateHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(text), onPressed: () => dateHandler())
        : OutlinedButton(
            onPressed: () => dateHandler(),
            child: Text(text,
                style: TextStyle(color: Theme.of(context).primaryColorDark)));
  }
}
