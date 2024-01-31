import 'package:flutter/material.dart';

class CustomProgressIndicator {
  final BuildContext context;

  CustomProgressIndicator(this.context);

  static bool progressbarStatus = false;
  static bool hideNormally = true;

  Future<void> showLoadingIndicator() async {
    if (progressbarStatus == false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            elevation: 0,
            content: LoadingIndicator(),
          );
        },
      );
      progressbarStatus = true;
    }
  }

  Future<void> hideLoadingIndicator() async {
    if (progressbarStatus && hideNormally) {
      Navigator.of(context).pop();
      progressbarStatus = false;
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
