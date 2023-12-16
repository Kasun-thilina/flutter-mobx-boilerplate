import '../../deserializer.dart';

class ApiListResponse<T>  {
  String? message;
  List<T>? body;

  ApiListResponse({this.message, this.body});

  ApiListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['body'] != null) {
      body = <T>[];
      json['body'].forEach((v) {
        body!.add(DeSerializer.fromJson(v));
      });
    }
  }
}
