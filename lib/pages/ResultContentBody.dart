import 'package:ada_flutter/DependencyResult.dart';
import 'package:ada_flutter/FeedbackWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../InfoBoxWidget.dart';
import '../ReportIncorrectDataWidget.dart';
class ResultContentBody extends StatelessWidget {
  ResultContentBody(this.dependencyResult);
  final DependencyResult dependencyResult;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 76,
            ),
            Text(
              "Package Details",
              style: TextStyle(fontSize: 14, color: Color(0xff626262)),
            ),
            Text(
              dependencyResult.completePackageName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 57,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoBoxWidget(
                    "Size In MB", dependencyResult.sizeInMB.toString()),
                InfoBoxWidget(
                    "Size In Bytes", dependencyResult.sizeInBytes.toString()),
                InfoBoxWidget(
                    "Last updated time", dependencyResult.formattedLastUpdate),
                ReportIncorrectDataWidget((){
                  _openSendEmailTab();
                }),
                FeedbackWidget((){
                  _openSendFeedbackEmailTab();
                })
              ],
            )
          ],
        ));
  }
  void _openSendEmailTab() async{
    final url =  "mailto:judeosby@gmail.com?subject=Invalid%20Data%20for ${dependencyResult.completePackageName}";
    if(await canLaunch(url)){
      await launch(url);
    }else{
      print("Cannot launch url");
    }
  }
  void _openSendFeedbackEmailTab() async{
    final url =  "mailto:judeosby@gmail.com?subject=Feedback/Suggestion";
    if(await canLaunch(url)){
      await launch(url);
    }else{
      print("Cannot launch url");
    }
  }
}
