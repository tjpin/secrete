import 'package:flutter/material.dart';

Widget label(ThemeData ctx, String label) {
  return Text(
    label,
    textAlign: TextAlign.start,
    style: ctx.textTheme.bodySmall!
        .copyWith(color: ctx.textTheme.bodySmall!.color!.withOpacity(0.7)),
  );
}
