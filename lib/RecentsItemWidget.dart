import 'package:flutter/material.dart';
class RecentsItemWidget extends StatelessWidget {
  RecentsItemWidget({@required this.child,this.position});
  final Widget child;
  final int position;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event){
        
      },
      child: Chip(label: child,
      labelStyle: TextStyle(
          color: Colors.white
      ),
      backgroundColor: Colors.blue,
      ),
    );
  }
}
