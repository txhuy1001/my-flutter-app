import 'package:my_app/entity/picture.dart';

class User {
  String? gender;
  String? name;
  String? email;
  String? dob;
  String? registered;
  String? phone;
  String? status;
  Picture? picture;

  User(
      {this.gender,
        this.name,
        this.email,
        this.dob,
        this.registered,
        this.phone,
        this.status,
        this.picture});

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'];
    email = json['email'];
    dob = json['dob'];
    registered = json['registered'];
    phone = json['phone'];
    status = json['status'];
    picture =
    json['picture'] != null ? Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['gender'] = gender;
    data['name'] = name;
    data['email'] = email;
    data['dob'] = dob;
    data['registered'] = registered;
    data['phone'] = phone;
    data['status'] = status;
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    return data;
  }
}