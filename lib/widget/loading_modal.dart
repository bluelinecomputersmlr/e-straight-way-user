import 'package:flutter/material.dart';

Future<dynamic> loadingDialogWidget(
  BuildContext context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.white,
        child: SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(color: Colors.purple),
          ),
        ),
      );
    },
  );
}
