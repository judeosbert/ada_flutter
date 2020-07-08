import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateButton extends StatelessWidget {
  const DonateButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          color: Colors.green,
          onPressed: () async {
            if (await canLaunch("https://www.buymeacoffee.com/forjude")) {
              await launch("https://www.buymeacoffee.com/forjude");
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              child: Text(
                "Donate and Support",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          )),
    );
  }
}
