import 'dart:async';
import 'package:ada_flutter/DependencyResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();
  static final _LOCAL_API = "http://localhost:8888/";
  static final _PROD_API = "http://68.183.90.53:8888/";
  static bool isDebug = false;

  static String get BASE_URL  => isDebug ? _LOCAL_API : _PROD_API;


  static final DETAIL_API = BASE_URL + "details/";
  static final STATUS_API = BASE_URL + "status/";
  static final RECENTS_API = BASE_URL + "recent";

  factory ApiManager() => _instance;

  ApiManager._internal();

  Future<DependencyResult> getDependencyDetails(String package) async {
    final url = DETAIL_API + package;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      print(responseMap);
      if (responseMap.containsKey("token")) {
        final result = await startStatusPoll(responseMap["token"]).first;
        return Future.value(result);
      } else {
        final dependencyResult = DependencyResult.fromJson(responseMap);
        return Future.value(dependencyResult);
      }
    } else {
      return Future.error("Failed to get package details. Please try again");
    }
  }

  Future<List<DependencyResult>> getRecentSearches() async{
    final response = await http.get(RECENTS_API);
    if(response.statusCode != 200) {
      return Future.value(List());
    }
    List<DependencyResult> responseList = (jsonDecode(response.body) as List<dynamic>).map((element) => DependencyResult.fromJson(element)).toList(growable: false);
    return responseList;
  }

  Stream<DependencyResult> startStatusPoll(String token)  {
    StreamController resultStream = StreamController<DependencyResult>();
    final url = STATUS_API + token;
    Timer.periodic(Duration(seconds: 5), (timer) async {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = json.decode(response.body);
        if (responseMap["pingToken"].length == 0) {
          timer.cancel();
          resultStream.close();
          return Future.error(
              "Failed to get package details. Please try again");
        } else {
          final dependencyResult = DependencyResult.fromJson(responseMap);
          timer.cancel();
          resultStream.add(dependencyResult);
          resultStream.close();
        }
      } else if (response.statusCode == 204) {
        print("Result not ready yet. Pinging in 5");
      } else {
        timer.cancel();
        resultStream.close();
        return Future.error("Failed to get package details. Please try again");
      }
    });
    return resultStream.stream;
  }
}
