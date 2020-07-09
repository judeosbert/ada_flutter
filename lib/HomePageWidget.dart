import 'package:ada_flutter/ApiManager.dart';
import 'package:ada_flutter/DependencyResult.dart';
import 'package:ada_flutter/InfoBoxWidget.dart';
import 'package:ada_flutter/ReportIncorrectDataWidget.dart';
import 'package:ada_flutter/SearchBarWidget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  DependencyResult dependencyResult;
  final SnackBar invalidPackageInputBar =
      SnackBar(content: Text("The package is empty"));
  TextEditingController textEditingController = TextEditingController();
  PageState pageState = PageState.INITIAL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [BoxShadow()],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADA",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          "Android Dependency Analyzer",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Beta",
                          style: TextStyle(fontSize:10,

                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SearchBarWidget(textEditingController, () {
                            final dependency = textEditingController.text;
                            if (dependency.length == 0) {
                              Flushbar(
                                title: "Error",
                                message: "The package is empty",
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              )..show(context);
                              return;
                            }
                            ApiManager()
                                .getDependencyDetails(dependency).asStream()
                                .listen((value) {
                              if (value == null) {
                                Flushbar(
                                  title: "Error",
                                  message: "The package is empty",
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                )..show(context);
                                setState(() {
                                  pageState = PageState.INITIAL;
                                });
                              } else {
                                setState(() {
                                  dependencyResult = value;
                                  pageState = PageState.RESULT;
                                });
                              }
                            });
                            setState(() {
                              pageState = PageState.LOADING;
                            });
                          })),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Powered by Flutter and Dart",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: mainBody),
          Container(
            margin: EdgeInsets.only(bottom:10.0),
            child: Stack(
              children:[
                  Align(
                    alignment:Alignment.bottomCenter,
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Created by Jude Osbert K",
                        style: TextStyle(
                          color:Color(0xFFc2c2c2)
                        ),),
                      ],
                    ),
                  ),
                  
              ] 
            ),
          ),
        ],
      ),
    );
  }

  Widget get mainBody {
    switch (pageState) {
      case PageState.INITIAL:
        return initialContentBody;
        break;
      case PageState.LOADING:
        return loadingContentBody;
        break;
      default:
        return resultContentBody;
        break;
    }
  }

  Widget get initialContentBody {
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

  Widget get loadingContentBody {
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

  Widget get resultContentBody {
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
}

enum PageState { INITIAL, LOADING, RESULT }
