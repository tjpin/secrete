import 'package:secrete/core.dart';

class ListCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final String? subtitle;
  final Color? bgColor;
  final double? cardHeight;
  final double? borderRadius;
  final VoidCallback onTap;
  const ListCard(
      {super.key,
      required this.title,
      required this.icon,
      this.subtitle,
      this.bgColor,
      this.cardHeight,
      this.borderRadius,
      required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctx = Theme.of(context);
    return Ink(
      height: cardHeight ?? 80,
      decoration: BoxDecoration(
          color: bgColor ?? ctx.appBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          boxShadow: [BoxShadow(color: ctx.primaryColor)]),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              child: Icon(
                icon,
                color: ctx.iconTheme.color,
              ),
            ),
            wsizer(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ctx.textTheme.bodyMedium,
                  ),
                  Text(
                    subtitle!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: ctx.textTheme.bodyMedium!.copyWith(
                        color:
                            ctx.textTheme.bodyMedium!.color!.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ).addHPadding(10),
      ),
    );
  }
}
