// To parse this JSON data, do
//
//     final discussion = discussionFromJson(jsonString);

import 'dart:convert';

List<Discussion> discussionFromJson(String str) => List<Discussion>.from(json.decode(str).map((x) => Discussion.fromJson(x)));

String discussionToJson(List<Discussion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discussion {
  String? id;
  String? tag;
  String? name;
  String? description;
  int? createdAt;
  int? updatedAt;
  String? createdById;
  LastMessage? lastMessage;
  List<Participant>? participants;

  Discussion({
    this.id,
    this.tag,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.createdById,
    this.lastMessage,
    this.participants,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    id: json["_id"],
    tag: json["tag"],
    name: json["name"],
    description: json["description"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    createdById: json["createdById"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "tag": tag,
    "name": name,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdById": createdById,
    "lastMessage": lastMessage?.toJson(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
  };
}

class LastMessage {
  String? senderId;
  String? text;
  FileClass? file;
  int? createdAt;

  LastMessage({
    this.senderId,
    this.text,
    this.file,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    senderId: json["senderId"],
    text: json["text"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "text": text,
    "file": file?.toJson(),
    "createdAt": createdAt,
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

class Participant {
  String? userId;
  bool? isAdmin;
  bool? hasNewNotif;
  int? addedAt;
  bool? isArchivedChat;
  UserDiscussion? user;

  Participant({
    this.userId,
    this.isAdmin,
    this.hasNewNotif,
    this.addedAt,
    this.isArchivedChat,
    this.user,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    userId: json["userId"],
    isAdmin: json["isAdmin"],
    hasNewNotif: json["hasNewNotif"],
    addedAt: json["addedAt"],
    isArchivedChat: json["isArchivedChat"],
    user: json["user"] == null ? null : UserDiscussion.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "isAdmin": isAdmin,
    "hasNewNotif": hasNewNotif,
    "addedAt": addedAt,
    "isArchivedChat": isArchivedChat,
    "user": user?.toJson(),
  };
}

class UserDiscussion {
  String? id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? photoUrl;

  UserDiscussion({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.photoUrl,
  });

  factory UserDiscussion.fromJson(Map<String, dynamic> json) => UserDiscussion(
    id: json["_id"],
    username: json["username"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "photoUrl": photoUrl,
  };
}