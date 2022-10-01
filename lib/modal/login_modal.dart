import 'dart:convert';

LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  LoginModal({
    this.status,
    this.message,
    this.data,
  });

  LoginModal.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.name,
    this.username,
    this.email,
    this.shortCode,
    this.countryCode,
    this.mobile,
    this.profileImage,
    this.token,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    shortCode = json['short_code'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    token = json['token'];
  }

  int? id;
  String? name;
  String? username;
  String? email;
  String? shortCode;
  String? countryCode;
  String? mobile;
  String? profileImage;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['short_code'] = shortCode;
    map['country_code'] = countryCode;
    map['mobile'] = mobile;
    map['profile_image'] = profileImage;
    map['token'] = token;
    return map;
  }
}
