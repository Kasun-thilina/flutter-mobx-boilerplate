import 'package:azlistview/azlistview.dart';

class User extends ISuspensionBean {
  String? id;
  String? email;
  String? tagIndex;
  bool isChecked = false;
  String? accessToken;
  String? refreshToken;
  String? username;
  String? phone;
  String? nextAction;

  User(
      {this.id,
      this.email,
      this.tagIndex,
      this.isChecked = false,
      this.accessToken,
      this.refreshToken,
      this.username,
      this.phone,
      this.nextAction});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    username = json['username'];
    phone = json['phone'];
    nextAction = json['nextAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['username'] = username;
    data['phone'] = phone;
    data['nextAction'] = nextAction;
    return data;
  }

  @override
  String getSuspensionTag() {
    return tagIndex ?? "";
  }
}
