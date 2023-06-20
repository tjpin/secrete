// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';

part 'indentification.g.dart';

@HiveType(typeId: 6)
class Indentification {
    @HiveField(0)
    String id;

    @HiveField(1)
    String name;

    @HiveField(2)
    String number;

    @HiveField(3)
    String? expiryDate;

    @HiveField(4)
    String? dateOfIssue;

    @HiveField(5)
    String? description;

    @HiveField(6)
    IdType type;
  Indentification({
    required this.id,
    required this.name,
    required this.number,
    this.expiryDate,
    this.dateOfIssue,
    this.description,
    required this.type,
  });
}


/// Indentification Type
@HiveType(typeId: 7)
enum IdType {
    @HiveField(0)
    other,

    @HiveField(1)
    passport,

    @HiveField(2)
    idCard,

    @HiveField(3)
    drivingLicence,

    @HiveField(4)
    healthCard,

    @HiveField(5)
    gatePass,

    @HiveField(6)
    accessCard,

    @HiveField(7)
    membership,

    @HiveField(8)
    insuranceCard;
}