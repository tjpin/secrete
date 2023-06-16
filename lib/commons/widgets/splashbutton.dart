import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {
  final ThemeData ctx;
  final String label;
  final Color color;
  final VoidCallback callBack;
  const SplashButton({
    Key? key,
    required this.ctx,
    required this.label,
    required this.color,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          label,
          style:
              ctx.textTheme.bodyMedium!.copyWith(color: color),
        ),
      ),
    );
  }
}