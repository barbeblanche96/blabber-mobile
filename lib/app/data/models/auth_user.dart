// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  String? accessToken;
  Authentication? authentication;
  UserInstance? user;

  AuthUser({
    this.accessToken,
    this.authentication,
    this.user,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    accessToken: json["accessToken"],
    authentication: json["authentication"] == null ? null : Authentication.fromJson(json["authentication"]),
    user: json["user"] == null ? null : UserInstance.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "authentication": authentication?.toJson(),
    "user": user?.toJson(),
  };
}

class Authentication {
  String? strategy;
  Payload? payload;

  Authentication({
    this.strategy,
    this.payload,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    strategy: json["strategy"],
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "strategy": strategy,
    "payload": payload?.toJson(),
  };
}

class Payload {
  int? iat;
  int? exp;
  String? aud;
  String? sub;
  String? jti;

  Payload({
    this.iat,
    this.exp,
    this.aud,
    this.sub,
    this.jti,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    iat: json["iat"],
    exp: json["exp"],
    aud: json["aud"],
    sub: json["sub"],
    jti: json["jti"],
  );

  Map<String, dynamic> toJson() => {
    "iat": iat,
    "exp": exp,
    "aud": aud,
    "sub": sub,
    "jti": jti,
  };
}

class UserInstance {
  String? id;
  String? lastname;
  String? firstname;
  int? createdAt;
  int? updatedAt;
  String? photoUrl;
  String? username;
  String? email;

  UserInstance({
    this.id,
    this.lastname,
    this.firstname,
    this.createdAt,
    this.updatedAt,
    this.photoUrl,
    this.username,
    this.email,
  });

  factory UserInstance.fromJson(Map<String, dynamic> json) => UserInstance(
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