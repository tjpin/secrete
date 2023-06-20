// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';

part 'wifi_account.g.dart';

@HiveType(typeId: 5)
class WifiAccount {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String password;

  @HiveField(3)
  String? location;

  @HiveField(4)
  String? pin;

  @HiveField(5)
  String? adminUsername;

  @HiveField(6)
  String? adminPassword;

  WifiAccount({
    required this.id,
    required this.name,
    required this.password,
    this.location,
    this.pin,
    this.adminUsername,
    this.adminPassword,
  });
}
