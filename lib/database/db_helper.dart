import 'package:secrete/core.dart';
import 'package:secrete/models/themeset.dart';

final databaseProvider = Provider((ref) => DatabaseHelper());

class DatabaseHelper {
  static Box<User> getUserBox() => Hive.box<User>('users');
  static Box<CardData> getCards() => Hive.box<CardData>('cards');
  static Box<Account> getAccount() => Hive.box<Account>('accounts');
  static Box<ThemeSet> getCurrentTheme() => Hive.box<ThemeSet>('themes');

  static const rid = Uuid();

  // Themes

  bool currentThemeLight() {
    if (getCurrentTheme().isEmpty) {
      ThemeSet data = ThemeSet(id: rid.v4(), isLightTheme: true);
      DatabaseHelper.getCurrentTheme().put(data.id, data);
      return getCurrentTheme().values.first.isLightTheme;
    }
    return getCurrentTheme().values.first.isLightTheme;
  }

  /// Accounts

  void addAccount(Account account) {
    getAccount().put(account.id, account);
  }

  void updateAccount(Account account) {
    getAccount().put(account.id, account);
  }

  void markFavourite(Account account, bool isFavorite) {
    final accn = getAccount().get(account.key);
    if (accn != null) {
      Account acc =
          Account(isFavorite: !isFavorite, isImported: account.isImported)
            ..id = account.id
            ..name = account.name
            ..username = account.username
            ..site = account.site
            ..password = account.password
            ..dateAdded = account.dateAdded;
      getAccount().put(acc.id, acc);
    }
  }

  void deleteAccount(Account account) {
    getAccount().delete(account.id);
  }

  void deleteAllAccount() {
    getAccount().clear();
  }

  void deleteAddedAccounts() {
    final importedAccounts = getAccount()
        .values
        .toList()
        .where((account) => account.isImported == false)
        .toList();
    final accountKeys = importedAccounts.map((e) => e.key).toList();
    getAccount().deleteAll(accountKeys);
  }

  void deleteImportedAccounts() {
    final importedAccounts = getAccount()
        .values
        .toList()
        .where((account) => account.isImported == true)
        .toList();
    final accountKeys = importedAccounts.map((e) => e.key).toList();
    getAccount().deleteAll(accountKeys);
  }

  (int addedCount, int importedCount, int favoriteCount, int total)
      accountCounts() {
    final addedAccounts = getAccount()
        .values
        .toList()
        .where((account) => account.isImported == false)
        .toList();
    final importedAccounts = getAccount()
        .values
        .toList()
        .where((account) => account.isImported == true)
        .toList();
    final favoriteAccounts = getAccount()
        .values
        .toList()
        .where((account) => account.isFavorite == true)
        .toList();
    final totalCount = addedAccounts.length + importedAccounts.length;
    return (
      addedAccounts.length,
      importedAccounts.length,
      favoriteAccounts.length,
      totalCount
    );
  }

  //cards
  void updateCard(CardData card) {
    getCards().put(card.id, card);
  }

  void deleteCard(CardData card) {
    getCards().delete(card.id);
  }

  void deleteAllCard() {
    getCards().clear();
  }
}
