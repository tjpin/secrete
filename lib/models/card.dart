import 'package:secrete/core.dart';

part 'card.g.dart';

@HiveType(typeId: 1)
class CardData extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? cardNumber;
  @HiveField(2)
  int? cardCvv;
  @HiveField(3)
  String? expiryDate;
  @HiveField(4)
  CardType? cardType;
  @HiveField(5)
  String? id;

  CardData(
      {this.id,
      this.name,
      this.cardNumber,
      this.cardCvv,
      this.expiryDate,
      this.cardType});
}

@HiveType(typeId: 2)
enum CardType {
  @HiveField(0)
  defaultCard,
  @HiveField(1)
  visa,
  @HiveField(2)
  mastercard,
  @HiveField(3)
  discover,
  @HiveField(4)
  paytime,
  @HiveField(5)
  jcb,
  @HiveField(6)
  amex,
  @HiveField(7)
  maestro
}
