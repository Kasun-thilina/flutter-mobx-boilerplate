import 'package:my_street_merchant/domain/deserializer.dart';

class ApiSingleResponse<T> {
  String? message;
  T? body;

  ApiSingleResponse({this.message, this.body});

  ApiSingleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    body = json['body'] != null ?  DeSerializer.fromJson(json['body'] ) : null;
  }
}