// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String? id;
  String? lastname;
  String? firstname;
  int? createdAt;
  int? updatedAt;
  String? photoUrl;
  String? username;
  String? email;

  User({
    this.id,
    this.lastname,
    this.firstname,
    this.createdAt,
    this.updatedAt,
    this.photoUrl,
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    lastname: json["lastname"],
    firstname: json["firstname"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    photoUrl: json["photoUrl"],
    username: json["username"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lastname": lastname,
    "firstname": firstname,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "photoUrl": photoUrl,
    "username": username,
    "email": email,
  };
}