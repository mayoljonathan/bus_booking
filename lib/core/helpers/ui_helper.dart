import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showAlertDialog(BuildContext context, String title, String content, List<Widget> actions, {
  dismissible = true
}) {
  actions = actions != null ? actions : <Widget> [
    FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop()
    ),
  ];

  return showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => dismissible,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)
          ),
          title: title != null ? Text(title) : Container(),
          content: content != null ? SingleChildScrollView(
            child: Text(content),
          ) : Container(height: 0),
          actions: actions
        ),
      );
    },
  );
}

void showConfirmDialog({
  @required BuildContext context, 
  String title, 
  String message, 
  String cancelText,
  String confirmText,
  TextStyle cancelStyle,
  TextStyle confirmStyle,
  VoidCallback onCancel,
  bool isConfirmButtonEmphasized = false,
  @required VoidCallback onConfirm
}) {

  TextStyle _defaultStyle = TextStyle(color: Theme.of(context).primaryColor);

  double borderRadius = 12.0;
  double topContentPadding = title != null ? 12.0 : 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        title: title != null ? Text(title) : Container(),
        contentPadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: message != null ? Container(
            padding: EdgeInsets.fromLTRB(24.0, topContentPadding, 24.0, 12.0),
            child: Text(message)
          ) : Container(height: 0),
        ),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius / 2)
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onCancel != null) onCancel();
            },
            child: Text(cancelText ?? 'CANCEL', style: _defaultStyle.merge(cancelStyle)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: FlatButton(
              color: isConfirmButtonEmphasized ? Theme.of(context).primaryColor : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius / 2)
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(confirmText ?? 'OK', style: _defaultStyle.merge(
                TextStyle(color: isConfirmButtonEmphasized ? Colors.white : null)
              ).merge(confirmStyle)),
            )
          )
        ],
      );
    }
  );
}


enum ToastLength { SHORT, LONG }
void showToast(String message, [ToastLength toastLength = ToastLength.SHORT]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength == ToastLength.LONG ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    // backgroundColor: Colors.grey
  );
}
