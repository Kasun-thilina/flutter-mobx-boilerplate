import 'model/response/auth/user.dart';

Type getType<T>() => T;

///Setup model classes here to deserialize dynamically based on response
class DeSerializer {
  static T fromJson<T>(dynamic json) {
    if (T == getType<User?>()) {
      return User.fromJson(json) as T;
    } else {
      return json as T;
    }

// switch (T) {
    //   case ApiResponse:
    //     return ApiResponse.fromJson(json) as T;
    //   case User:
    //     return User.fromJson(json) as T;
    //   default:
    //     return json as T;
    // }
  }
}
