import 'package:flutter/material.dart';

class ReportIncorrectDataWidget extends StatelessWidget {
  ReportIncorrectDataWidget(this.onPressed);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color(0xFFFF0000),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
          )
        ]
          ),
      child: SizedBox(
        width: 214,
        height: 164,
        child: MaterialButton(
          onPressed:onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning,color: Colors.white,),
              SizedBox(height: 10,),
              Text(
                "Report Incorrect Data",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white,
                      fontSize: 18
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
