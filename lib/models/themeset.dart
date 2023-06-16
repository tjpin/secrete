// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';

part 'themeset.g.dart';


@HiveType(typeId: 3)
class ThemeSet {
    @HiveField(0)
    String id;

    @HiveField(1)
    bool isLightTheme;
  ThemeSet({
    required this.id,
    this.isLightTheme = true,
  });
}
