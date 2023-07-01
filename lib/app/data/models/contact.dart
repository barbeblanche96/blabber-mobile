// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  String? id;
  int? createdAt;
  int? updatedAt;
  bool? blockedUser1;
  bool? blockedUser2;
  String? userId2;
  String? userId1;
  UserContact? user1;
  UserContact? user2;

  Contact({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blockedUser1,
    this.blockedUser2,
    this.userId2,
    this.userId1,
    this.user1,
    this.user2,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    blockedUser1: json["blockedUser1"],
    blockedUser2: json["blockedUser2"],
    userId2: json["userId2"],
    userId1: json["userId1"],
    user1: json["user1"] == null ? null : UserContact.fromJson(json["user1"]),
    user2: json["user2"] == null ? null : UserContact.fromJson(json["user2"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "blockedUser1": blockedUser1,
    "blockedUser2": blockedUser2,
    "userId2": userId2,
    "userId1": userId1,
    "user1": user1?.toJson(),
    "user2": user2?.toJson(),
  };
}

class UserContact {
  String? lastname;
  String? firstname;
  String? email;
  String? username;
  String? photoUrl;

  UserContact({
    this.lastname,
    this.firstname,
    this.email,
    this.username,
    this.photoUrl,
  });

  factory UserContact.fromJson(Map<String, dynamic> json) => UserContact(
    lastname: json["lastname"],
    firstname: json["firstname"],
    email: json["email"],
    username: json["username"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "lastname": lastname,
    "firstname": firstname,
    "email": email,
    "username": username,
    "photoUrl": photoUrl,
  };
}