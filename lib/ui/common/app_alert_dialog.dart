import 'package:coeops/ui/common/raw_dialog.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String message;
  final Function onPressed;
  final String actionText;

  AppAlertDialog(
      {@required this.message, @required this.onPressed, this.actionText});

  @override
  Widget build(BuildContext context) {
    return RawDialog(
      message: message,
      actions: [
        Container(
          width: 250,
          height: 45,
          child: RaisedButton(
            color: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: onPressed,
            child: Text(
              actionText ?? "Okay",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
