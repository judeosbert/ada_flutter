import 'package:flutter/material.dart';

class ChangeListPopup extends StatelessWidget {
  ChangeListPopup({@required this.onDismiss});
  final Function onDismiss;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border.all(color: Colors.blue,width: 1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Changelog",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 16.0),),
            Text("- Support for custom repositories."),
            Text("- Bug Fixes"),
            Text("Updated on : 5th August 2020"),
            RaisedButton(onPressed: (){
                onDismiss();
            },
              color: Colors.blue,
            child: Text("Close",style: TextStyle(
              color: Colors.white
            ),),)
          ],
        ),
      ),
    );
  }
}
