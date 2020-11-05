// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.address,
    this.token,
    this.avatar,
  });

  String id;
  String username;
  String fullName;
  String phoneNumber;
  String email;
  String address;
  String token;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        token: json["token"] == null ? null : json["token"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "full_name": fullName == null ? null : fullName,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "token": token == null ? null : token,
        "avatar": avatar == null ? null : avatar,
      };
}
