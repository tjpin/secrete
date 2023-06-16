import 'dart:convert';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Uint8List> encryption() async {
  const secureStorage = FlutterSecureStorage();
  final encryptionKeyString = await secureStorage.read(key: 'encryptionKey');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'encryptionKey',
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: 'encryptionKey');
  final encryptionKeyUint8List = base64Url.decode(key!);
  return encryptionKeyUint8List;
}
