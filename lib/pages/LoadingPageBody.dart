import 'package:flutter/material.dart';

class LoadingPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            "https://i.ibb.co/bKvJ84S/searching.gif",
            height: 265,
            width: 474,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Hang on, this might take some moments. You can consider donating so that I can upgrade the servers",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
