import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget(this.hint,this.textEditingController, this.onSearch,{this.noAction});

  final Function onSearch;
  final String hint;
  final bool noAction;
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
                hintText:widget.hint
            ),
          ),
        ),
        !widget.noAction?FlatButton(
          color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
//              if (isSearchBoxEmpty) {
//                widget.onSearch();
//              } else {
//                _resetState();
//              }
            widget.onSearch();
            },
            child: true ? Text("Search") : Icon(Icons.close)):Container()
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
