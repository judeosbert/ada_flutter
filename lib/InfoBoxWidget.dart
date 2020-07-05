import 'package:flutter/material.dart';

class InfoBoxWidget extends StatelessWidget {
  InfoBoxWidget(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
          )
        ]
          ),
      child: SizedBox(
        width: 214,
        height: 164,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(
              title,
              style: TextStyle(color: Color(0xFF626262),fontSize: 14),
            ),
            SizedBox(height: 10,),
            SelectableText(
              value,
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black,
                    fontSize: 24
                  ),
            )
          ],
        ),
      ),
    );
  }
}
