import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:secrete/commons/helpers/account_bottomsheet.dart';
import 'package:secrete/commons/helpers/confirm_delete.dart';
import 'package:secrete/commons/widgets/edit_accont_dialog.dart';
import 'package:secrete/core.dart';

class FavoriteAccounts extends ConsumerStatefulWidget {
  const FavoriteAccounts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddedAccountsState();
}

class _AddedAccountsState extends ConsumerState<FavoriteAccounts> {

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable: DatabaseHelper.getAccount().listenable(),
        builder: (context, box, _) {
          List<Account> accounts = List<Account>.from(box.values)
              .where((account) => account.isFavorite == true)
              .toList();
          return accounts.isEmpty
              ? const Center(child: Text("No favorited account:"))
              : ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, i) => Slidable(
                        key: const ValueKey(1),
                        startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                autoClose: true,
                                icon: Icons.edit,
                                label: 'Edit',
                                backgroundColor:
                                    ctx.appBarTheme.backgroundColor!,
                                onPressed: (_) => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        UpdateAccountDialog(
                                          account: accounts[i],
                                        )),
                              ),
                              SlidableAction(
                                  icon: Icons.delete_forever,
                                  autoClose: true,
                                  foregroundColor: Colors.red,
                                  backgroundColor:
                                      ctx.appBarTheme.backgroundColor!,
                                  label: 'Delete',
                                  onPressed: (_) => confirmDelete(
                                      context,
                                      () => DatabaseHelper()
                                          .deleteAccount(accounts[i]))),
                            ]),
                        child: AccountListTile(
                          account: accounts[i],
                          onAction: () =>
                              viewDetails(context, ctx, accounts[i]),
                          makeFavourite: () => DatabaseHelper()
                              .markFavourite(
                                  accounts[i], accounts[i].isFavorite),
                        ),
                      ));
        });
  }
}
