// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:secrete/core.dart';

class AccountListTile extends StatelessWidget {
  Account account;
  VoidCallback makeFavourite;
  VoidCallback? onAction;
  Widget? icon;
  AccountListTile({
    Key? key,
    required this.account,
    required this.makeFavourite,
    this.icon,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: ctx.scaffoldBackgroundColor.withBlue(70),
        child: Text(
          account.name!.substring(0, 1),
          style: ctx.textTheme.bodyLarge,
        ),
      ),
      onTap: onAction ?? () {},
      title: Text(
        account.name!,
        style: ctx.textTheme.bodyMedium!
            .copyWith(color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5)),
      ),
      trailing: icon ?? IconButton(
          onPressed: makeFavourite,
          icon: account.isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: Colors.orange,
                  size: 20,
                )
              : Icon(
                  Icons.favorite_outline,
                  color: ctx.iconTheme.color,
                  size: 20,
                )),
    );
  }
}
