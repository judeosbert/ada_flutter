import 'package:ada_flutter/ApiManager.dart';
import 'package:ada_flutter/DependencyResult.dart';
import 'package:ada_flutter/HomePageWidget.dart';
import 'package:ada_flutter/RecentsItemWidget.dart';
import 'package:flutter/material.dart';

class RecentSearchesWidget extends StatefulWidget {
  RecentSearchesWidget({@required this.onClick});

  final Function(DependencyResult) onClick;

  @override
  _RecentSearchesWidgetState createState() => _RecentSearchesWidgetState();
}

class _RecentSearchesWidgetState extends State<RecentSearchesWidget> {
  final ApiManager manager = ApiManager();
  PageState pageState = PageState.INITIAL;
  List<DependencyResult> recentsList = List();

  @override
  Widget build(BuildContext context) {
    if (recentsList.isEmpty) {
      return Container();
    } else {
      return Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: ListView.builder(
            itemBuilder: (context, position) {
              if (position == 0) {
                return Center(
                    child: Chip(
                        label: Text("Recent Searches")));
              }
              position -= 1;
              return Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      widget.onClick(recentsList[position]);
                    },
                    child: RecentsItemWidget(
                      child: Text(
                        recentsList[position].completePackageName,
                        textAlign: TextAlign.center,
                      ),
                      position: position + 1,
                    ),
                  ),
                ),
              );
            },
            itemCount: recentsList.length + 1,
            scrollDirection: Axis.horizontal,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        pageState = PageState.LOADING;
      });
      manager.getRecentSearches().then((value) {
        setState(() {
          pageState = PageState.RESULT;
          recentsList = value;
        });
      });
    });
  }
}
