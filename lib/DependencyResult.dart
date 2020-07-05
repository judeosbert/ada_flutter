import 'package:intl/intl.dart';

class DependencyResult {
  int id;
  String domain;
  String module;
  String version;
  int sizeInBytes;
  String pingToken;
  DateTime lastUpdate;
  bool isSuccess;

  String get completePackageName => "$domain:$module:$version";
  String  get sizeInMB => (sizeInBytes/(1024*1024)).toStringAsFixed(2);
  String get formattedLastUpdate {
    final localTime = lastUpdate.toLocal();
    final String formattedDate = DateFormat.yMMMMd().format(localTime);
    return formattedDate;
  }

  DependencyResult(
      {this.id, this.domain, this.module, this.version, this.sizeInBytes, this.pingToken, this.lastUpdate, this.isSuccess});

  factory DependencyResult.fromJson(Map<String, dynamic> json){
    return DependencyResult(
      id: json["id"],
      domain: json["domain"],
      module: json["module"],
      version: json["version"],
      sizeInBytes: json["sizeInBytes"],
      pingToken: json["pingToken"],
      lastUpdate: DateTime.parse(json["lastUpdate"]),
      isSuccess: json["isSuccess"],
    );
  }
}