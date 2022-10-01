import 'dart:convert';

HomeModal homeModalFromJson(String str) => HomeModal.fromJson(json.decode(str));

String homeModalToJson(HomeModal data) => json.encode(data.toJson());

class HomeModal {
  HomeModal({
    this.status,
    this.message,
    this.data,
  });

  HomeModal.fromJson(dynamic json) {
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
    this.specialist,
    this.booking,
  });

  Data.fromJson(dynamic json) {
    specialist = json['specialist'] != null ? Specialist.fromJson(json['specialist']): null;
    if (json['booking'] != null) {
      booking = [];
      json['booking'].forEach((v) {
        booking?.add(Booking.fromJson(v));
      });
    }
  }

  Specialist? specialist;
  List<Booking>? booking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['specialist'] = specialist;
    if (booking != null) {
      map['booking'] = booking?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking({
    this.id,
    this.orderId,
    this.date,
    this.time,
    this.type,
    this.status,
    this.meetingLink,
  });

  Booking.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    status = json['status'];
    meetingLink = json['meeting_link'];
  }

  int? id;
  String? orderId;
  String? date;
  String? time;
  String? type;
  String? status;
  String? meetingLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['date'] = date;
    map['time'] = time;
    map['type'] = type;
    map['status'] = status;
    map['meeting_link'] = meetingLink;
    return map;
  }
}

Specialist specialistFromJson(String str) =>
    Specialist.fromJson(json.decode(str));

String specialistToJson(Specialist data) => json.encode(data.toJson());

class Specialist {
  Specialist({
    this.id,
    this.name,
    this.specialist,
    this.profileImage,
  });

  Specialist.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    specialist = json['specialist'];
    profileImage = json['profile_image'];
  }

  int? id;
  String? name;
  String? specialist;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['specialist'] = specialist;
    map['profile_image'] = profileImage;
    return map;
  }
}
