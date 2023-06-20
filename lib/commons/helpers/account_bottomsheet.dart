import 'package:intl/intl.dart';

import '../../core.dart';
import '../widgets/accounts_detail.dart';
import '../widgets/label.dart';

Future<void> viewDetails(
    BuildContext context, ThemeData ctx, Account account) async {
  await showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    avatar: Icon(
                      Icons.account_circle,
                      color: ctx.iconTheme.color,
                    ),
                    label: Text(account.name!),
                    labelStyle: ctx.textTheme.bodySmall,
                  ),
                  AccountDetailField(
                    label: account.username!,
                  ),
                  label(
                    ctx,
                    'Username',
                  ),
                  AccountDetailField(
                    label: account.site!,
                  ),
                  label(
                    ctx,
                    'Site url',
                  ),
                  AccountDetailField(
                    label: account.password!,
                  ),
                  label(
                    ctx,
                    'Account password',
                  ),
                  AccountDetailField(
                    label:
                        DateFormat("yyyy - MM - dd").format(account.dateAdded!),
                  ),
                  label(
                    ctx,
                    'Date Added: yyyy - mm - dd',
                  )
                ],
              ).addAllPadding(10),
            ),
          ));
}
