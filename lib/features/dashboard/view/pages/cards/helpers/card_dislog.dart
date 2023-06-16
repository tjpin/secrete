import 'package:flutter/material.dart';

import '../newcard_dialog.dart';

Future<void> addCardDialog(
  BuildContext context,
) async {
  showDialog(
      context: context,
      builder: (context) {
        return const CardDialogContainer();
      });
}