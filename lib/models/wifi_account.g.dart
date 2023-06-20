// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WifiAccountAdapter extends TypeAdapter<WifiAccount> {
  @override
  final int typeId = 5;

  @override
  WifiAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WifiAccount(
      id: fields[0] as String,
      name: fields[1] as String,
      password: fields[2] as String,
      location: fields[3] as String?,
      pin: fields[4] as String?,
      adminUsername: fields[5] as String?,
      adminPassword: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WifiAccount obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.pin)
      ..writeByte(5)
      ..write(obj.adminUsername)
      ..writeByte(6)
      ..write(obj.adminPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WifiAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
