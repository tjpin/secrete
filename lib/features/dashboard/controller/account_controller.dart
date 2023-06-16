import 'package:file_picker/file_picker.dart';
import 'package:secrete/core.dart';
import 'dart:io';

final databseAccountControllerProvider = Provider<AccountController>((ref) {
  return AccountController(dbProvider: ref.watch(databaseProvider));
});

class AccountController {
  final DatabaseHelper dbProvider;
  AccountController({required this.dbProvider});
  static const uid = Uuid();

  void createAccount(
      BuildContext context,
      bool favoritedValue,
      TextEditingController nameController,
      TextEditingController siteController,
      TextEditingController passwordController,
      TextEditingController usernameController,
      VoidCallback clearFields) {
    Account account = Account(isFavorite: favoritedValue, isImported: false)
      ..id = uid.v4()
      ..name = nameController.text
      ..password = passwordController.text
      ..site = siteController.text
      ..isFavorite = favoritedValue
      ..isImported = false
      ..dateAdded = DateTime.now()
      ..username = usernameController.text;
    dbProvider.addAccount(account);
    clearFields();
    successToast("${account.name} created successifuly");
    Navigator.pop(context);
  }

  void editAccount(BuildContext context, Account account) {
    dbProvider.updateAccount(account);
    successToast("${account.name} updates successifuly");
    Navigator.pop(context);
  }

  Future<List<List<String>>> readCsvFile(String filePath) async {
    try {
      final file = File(filePath);
      final lines = await file.readAsLines();

      final List<List<String>> rows = [];

      for (final line in lines) {
        final List<String> row = line.split(',');
        rows.add(row);
      }

      return rows;
    } catch (e) {
      return [];
    }
  }

  void importAccounts(AccountController ctl) async {
    final results = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        allowMultiple: false,
        onFileLoading: (_) => successToast('Importing accounts...'));
    final file = results!.files.first.path;
    final data = await ctl.readCsvFile(file.toString());

    /// data: returns [name, url, username, password, note]
    ctl.dbProvider.deleteImportedAccounts();
    for (final row in data) {
      Account acc = Account(isFavorite: false, isImported: true)
        ..id = uid.v4()
        ..name = row[0]
        ..site = row[1]
        ..username = row[2]
        ..password = row[3]
        ..dateAdded = DateTime.now();
      ctl.dbProvider.addAccount(acc);
    }
    successToast("${data.length} accounts imported");
  }
}
