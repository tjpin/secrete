import '../../core.dart';
import '../../models/indentification.dart';
import '../../models/themeset.dart';
import '../../models/wifi_account.dart';
import '../../security/db_encryption.dart';

Future<void> initializeDatabase() async {
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(CardDataAdapter());
  Hive.registerAdapter(CardTypeAdapter());
  Hive.registerAdapter(ThemeSetAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(IdTypeAdapter());
  Hive.registerAdapter(IndentificationAdapter());
  Hive.registerAdapter(WifiAccountAdapter());

  await Hive.openBox<User>("users",
      encryptionCipher: HiveAesCipher(await encryption()));
  await Hive.openBox<CardData>("cards",
      encryptionCipher: HiveAesCipher(await encryption()));
  await Hive.openBox<Account>("accounts",
      encryptionCipher: HiveAesCipher(await encryption()));
  await Hive.openBox<ThemeSet>("themes",
      encryptionCipher: HiveAesCipher(await encryption()));
  await Hive.openBox<Indentification>("indentifications",
      encryptionCipher: HiveAesCipher(await encryption()));
  await Hive.openBox<WifiAccount>("wifiaccounts",
      encryptionCipher: HiveAesCipher(await encryption()));
}
