import 'package:flutter/material.dart';
class InitialPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            "https://i.ibb.co/6v0p1pm/waiting.png",
            height: 265,
            width: 474,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Waiting for you to search",
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
