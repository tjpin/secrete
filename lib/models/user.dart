// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String id;

  @HiveField(1)
  String pincode;

  @HiveField(2)
  String? username;

  @HiveField(3)
  Map<String, String>? questions;

  User({
    required this.id,
    this.username,
    this.questions,
    required this.pincode,
  });
}

