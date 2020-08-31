import 'package:ada_flutter/ApiManager.dart';
import 'package:flutter/material.dart';
class StatBox extends StatefulWidget {
  @override
  _StatBoxState createState() => _StatBoxState();
}

class _StatBoxState extends State<StatBox> {
  int packageCount = -1;
  @override
  Widget build(BuildContext context) {
    if(packageCount <=0) {
      return Container();
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text(packageCount.toString(),style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        Text("packages indexed so far",style: TextStyle(
          color: Colors.white
        ),)],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      ApiManager().getStats().then((value){
        setState(() {
          packageCount = value;
        });
      });
    });
  }
}
