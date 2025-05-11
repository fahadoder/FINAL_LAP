import 'dart:convert';

MyCode usersFromMap(String str) => MyCode.fromMap(json.decode(str));

String usersToMap(MyCode data) => json.encode(data.toMap());

class MyCode {
  final int? id;
  final String Number;
  final String Code;

  MyCode({
    this.id,
    required this.Number,
    required this.Code,
  });

  factory MyCode.fromMap(Map<String, dynamic> json) => MyCode(
    id: json["id"],
    Number: json["Number"],
    Code: json["Code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Number": Number,
    "Code": Code,
  };
}