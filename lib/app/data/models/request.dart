// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

List<Request> requestFromJson(String str) => List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  String? id;
  int? createdAt;
  int? updatedAt;
  bool? accepted;
  String? senderId;
  String? receiverId;
  Receiver? sender;
  Receiver? receiver;

  Request({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.accepted,
    this.senderId,
    this.receiverId,
    this.sender,
    this.receiver,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    accepted: json["accepted"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "accepted": accepted,
    "senderId": senderId,
    "receiverId": receiverId,
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
  };
}

class Receiver {
  String? lastname;
  String? firstname;
  String? email;
  String? username;
  String? photoUrl;

  Receiver({
    this.lastname,
    this.firstname,
    this.email,
    this.username,
    this.photoUrl,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
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
