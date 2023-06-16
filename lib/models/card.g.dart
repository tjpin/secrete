// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDataAdapter extends TypeAdapter<CardData> {
  @override
  final int typeId = 1;

  @override
  CardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardData(
      id: fields[5] as String?,
      name: fields[0] as String?,
      cardNumber: fields[1] as int?,
      cardCvv: fields[2] as int?,
      expiryDate: fields[3] as String?,
      cardType: fields[4] as CardType?,
    );
  }

  @override
  void write(BinaryWriter writer, CardData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardCvv)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.cardType)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardTypeAdapter extends TypeAdapter<CardType> {
  @override
  final int typeId = 2;

  @override
  CardType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CardType.defaultCard;
      case 1:
        return CardType.visa;
      case 2:
        return CardType.mastercard;
      case 3:
        return CardType.discover;
      case 4:
        return CardType.paytime;
      case 5:
        return CardType.jcb;
      case 6:
        return CardType.amex;
      case 7:
        return CardType.maestro;
      default:
        return CardType.defaultCard;
    }
  }

  @override
  void write(BinaryWriter writer, CardType obj) {
    switch (obj) {
      case CardType.defaultCard:
        writer.writeByte(0);
        break;
      case CardType.visa:
        writer.writeByte(1);
        break;
      case CardType.mastercard:
        writer.writeByte(2);
        break;
      case CardType.discover:
        writer.writeByte(3);
        break;
      case CardType.paytime:
        writer.writeByte(4);
        break;
      case CardType.jcb:
        writer.writeByte(5);
        break;
      case CardType.amex:
        writer.writeByte(6);
        break;
      case CardType.maestro:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
