import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class BaseResponse {
  int? status;
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  String? id;
  String? name;
  int? numOfNotification;

  CustomerResponse(this.id, this.name, this.numOfNotification);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  String? email;
  String? phone;
  String? link;

  ContactsResponse(this.email, this.phone, this.link);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthResponse extends BaseResponse {
  CustomerResponse? customer;
  ContactsResponse? contacts;

  AuthResponse(this.customer, this.contacts);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
