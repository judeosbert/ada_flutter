import 'package:ada_flutter/ApiManager.dart';
import 'package:ada_flutter/DependencyResult.dart';
import 'package:ada_flutter/InfoBoxWidget.dart';
import 'package:ada_flutter/RecentSearchesWidget.dart';
import 'package:ada_flutter/ReportIncorrectDataWidget.dart';
import 'package:ada_flutter/SearchBarWidget.dart';
import 'package:ada_flutter/pages/InitialPageBody.dart';
import 'package:ada_flutter/pages/LoadingPageBody.dart';
import 'package:ada_flutter/pages/ResultContentBody.dart';
import 'package:ada_flutter/pages/SharedPrefHelper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChangeListPopup.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  DependencyResult dependencyResult;
  final SnackBar invalidPackageInputBar =
      SnackBar(content: Text("The package is empty"));
  TextEditingController textEditingController = TextEditingController();
  TextEditingController repoTextEditingController = TextEditingController();
  PageState pageState = PageState.INITIAL;
  bool showShowChangeLogPopup = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool flag = await SharedPrefHelper().shouldShowPopup();
      setState(() {
        showShowChangeLogPopup = flag;
      });
    });
  }

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
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SearchBarWidget(
                                  "(Optional) repository eg: maven { url 'https://maven.juspay.in/jp-build-packages/release/' }",
                                  repoTextEditingController,null,noAction: true,)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SearchBarWidget(
                                  "Search with full package name ex: com.example.product:module:version",
                                  textEditingController, () {
                                final dependency = textEditingController.text;
                                final repo = repoTextEditingController.text;
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
                                    .getDependencyDetails(repo,dependency)
                                    .asStream()
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
                              },noAction: false,)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.0, top: 10.0),
                          child: SelectableText(
                            "example: com.greedygame.sdkx:core:0.0.71",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 16.0),
                            child: Text(
                              "Doesn't support annotation processors.\n All dependencies are interpreted as `implementation` ",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Powered by Flutter and Dart",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(children: [
            SizedBox.fromSize(
                size: Size.fromHeight(50.0),
                child: RecentSearchesWidget(
                  onClick: (dependency) {
                    setState(() {
                      pageState = PageState.RESULT;
                      dependencyResult = dependency;
                    });
                  },
                )),
            Align(
                alignment: Alignment.centerRight,
                child: showShowChangeLogPopup
                    ? Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        child: ChangeListPopup(
                          onDismiss: () {
                            SharedPrefHelper().closeChangeLogPopup();
                            setState(() {
                              showShowChangeLogPopup = false;
                            });
                          },
                        ))
                    : Container())
          ]),
          Expanded(child: mainBody),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Created by Jude Osbert K",
                      style: TextStyle(color: Color(0xFFc2c2c2)),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget get mainBody {
    switch (pageState) {
      case PageState.INITIAL:
        return InitialPageBody();
        break;
      case PageState.LOADING:
        return LoadingPageBody();
        break;
      default:
        return ResultContentBody(dependencyResult);
        break;
    }
  }
}

enum PageState { INITIAL, LOADING, RESULT }
