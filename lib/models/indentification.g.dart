// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indentification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndentificationAdapter extends TypeAdapter<Indentification> {
  @override
  final int typeId = 6;

  @override
  Indentification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Indentification(
      id: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as String,
      expiryDate: fields[3] as String?,
      dateOfIssue: fields[4] as String?,
      description: fields[5] as String?,
      type: fields[6] as IdType,
    );
  }

  @override
  void write(BinaryWriter writer, Indentification obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.dateOfIssue)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndentificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IdTypeAdapter extends TypeAdapter<IdType> {
  @override
  final int typeId = 7;

  @override
  IdType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IdType.other;
      case 1:
        return IdType.passport;
      case 2:
        return IdType.idCard;
      case 3:
        return IdType.drivingLicence;
      case 4:
        return IdType.healthCard;
      case 5:
        return IdType.gatePass;
      case 6:
        return IdType.accessCard;
      case 7:
        return IdType.membership;
      case 8:
        return IdType.insuranceCard;
      default:
        return IdType.other;
    }
  }

  @override
  void write(BinaryWriter writer, IdType obj) {
    switch (obj) {
      case IdType.other:
        writer.writeByte(0);
        break;
      case IdType.passport:
        writer.writeByte(1);
        break;
      case IdType.idCard:
        writer.writeByte(2);
        break;
      case IdType.drivingLicence:
        writer.writeByte(3);
        break;
      case IdType.healthCard:
        writer.writeByte(4);
        break;
      case IdType.gatePass:
        writer.writeByte(5);
        break;
      case IdType.accessCard:
        writer.writeByte(6);
        break;
      case IdType.membership:
        writer.writeByte(7);
        break;
      case IdType.insuranceCard:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
