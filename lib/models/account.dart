// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../core.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? password;
  @HiveField(3)
  DateTime? dateAdded;
  @HiveField(4)
  bool isFavorite;
  @HiveField(5)
  bool isImported;
  @HiveField(6)
  String? site;
  @HiveField(7)
  String? id;
  Account({
    this.name,
    this.username,
    this.password,
    this.dateAdded,
    required this.isFavorite,
    required this.isImported,
    this.site,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'password': password,
      'dateAdded': dateAdded?.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
      'isImported': isImported,
      'site': site,
      'id': id,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      name: map['name'] != null ? map['name'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      dateAdded: map['dateAdded'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateAdded'] as int) : null,
      isFavorite: map['isFavorite'] as bool,
      isImported: map['isImported'] as bool,
      site: map['site'] != null ? map['site'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);
}
