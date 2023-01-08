import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Widget child;
  final bool isBusy;
  final bool hasError;
  final String errorText;

  CustomLoadingIndicator({
    Key? key,
    required this.child,
    this.isBusy = false,
    this.hasError = false,
    this.errorText = 'Oops something went wrong!!!',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isBusy
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : hasError
              ? Container(
        alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_outlined,
                        semanticLabel: 'error',
                        size: 48.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          errorText,
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : child,
    );
  }
}
