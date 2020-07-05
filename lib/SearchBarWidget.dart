import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget(this.textEditingController, this.onSearch);

  final Function onSearch;
  final TextEditingController textEditingController;

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isSearchBoxEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (String value){
              widget.onSearch();
            },
            controller: widget.textEditingController,
            onChanged: (String value){
              if(value.length == 0){
                _resetState();
              }
              else{
                setState(() {
                  isSearchBoxEmpty = false;
                });
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    "Search with full package name ex: com.example.product:module:version"),
          ),
        ),
        FlatButton(
            onPressed: () {
              if (isSearchBoxEmpty) {
                widget.onSearch();
              } else {
                _resetState();
              }
            },
            child: isSearchBoxEmpty ? Text("Search") : Icon(Icons.close))
      ],
    );
  }
  void _resetState(){
    widget.textEditingController.clear();
    setState(() {
      isSearchBoxEmpty = true;
    });
  }
}
