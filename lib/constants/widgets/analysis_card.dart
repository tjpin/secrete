import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  const AnalysisCard({
    Key? key,
    required this.title,
    required this.count,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              icon,
              color: ctx.textTheme.bodySmall!.color,
            ),
            label: Text(
              title,
              style: ctx.textTheme.bodySmall,
            )),
        Text(count)
      ],
    );
  }
}