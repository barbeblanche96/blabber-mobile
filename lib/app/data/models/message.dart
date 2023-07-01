// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  String? id;
  String? text;
  int? createdAt;
  int? updatedAt;
  String? senderId;
  FileClass? file;
  List<Reaction>? reactions;
  String? discussionId;
  String? responseToMessageId;
  ResponseToMessage? responseToMessage;
  Sender? sender;

  Message({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.senderId,
    this.file,
    this.reactions,
    this.discussionId,
    this.responseToMessageId,
    this.responseToMessage,
    this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    text: json["text"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    senderId: json["senderId"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    reactions: json["reactions"] == null ? [] : List<Reaction>.from(json["reactions"]!.map((x) => Reaction.fromJson(x))),
    discussionId: json["discussionId"],
    responseToMessageId: json["responseToMessageId"],
    responseToMessage: json["responseToMessage"] == null ? null : ResponseToMessage.fromJson(json["responseToMessage"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "text": text,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "senderId": senderId,
    "file": file?.toJson(),
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x.toJson())),
    "discussionId": discussionId,
    "responseToMessageId": responseToMessageId,
    "responseToMessage": responseToMessage?.toJson(),
    "sender": sender?.toJson(),
  };
}

class FileClass {
  String? originalName;
  String? pathUrl;
  int? size;

  FileClass({
    this.originalName,
    this.pathUrl,
    this.size,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    originalName: json["originalName"],
    pathUrl: json["pathUrl"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "originalName": originalName,
    "pathUrl": pathUrl,
    "size": size,
  };
}

class Reaction {
  String? userId;
  String? emoji;

  Reaction({
    this.userId,
    this.emoji,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
    userId: json["userId"],
    emoji: json["emoji"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "emoji": emoji,
  };
}

class ResponseToMessage {
  String? id;
  String? text;
  FileClass? file;

  ResponseToMessage({
    this.id,
    this.text,
    this.file,
  });

  factory ResponseToMessage.fromJson(Map<String, dynamic> json) => ResponseToMessage(
    id: json["_id"],
    text: json["text"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "text": text,
    "file": file?.toJson(),
  };
}

class Sender {
  String? id;
  String? lastname;
  String? firstname;
  String? email;
  String? username;

  Sender({
    this.id,
    this.lastname,
    this.firstname,
    this.email,
    this.username,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    lastname: json["lastname"],
    firstname: json["firstname"],
    email: json["email"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lastname": lastname,
    "firstname": firstname,
    "email": email,
    "username": username,
  };
}
