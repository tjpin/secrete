// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';

class AddedAccounts extends ConsumerStatefulWidget {
  const AddedAccounts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddedAccountsState();
}

class _AddedAccountsState extends ConsumerState<AddedAccounts> {
  List<Account> accounts = [];

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable: DatabaseHelper.getAccount().listenable(),
        builder: (context, box, _) {
          accounts = List<Account>.from(box.values)
              .where((account) => account.isImported == false)
              .toList();
          return accounts.isEmpty
              ? const Center(
                  child: Text("No Account to show!"),
                )
              : ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, i) => Slidable(
                        key: const ValueKey(0),
                        direction: Axis.horizontal,
                        startActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            autoClose: true,
                            icon: Icons.edit,
                            label: 'Edit',
                            backgroundColor: ctx.appBarTheme.backgroundColor!,
                            onPressed: (_) => showDialog(
                                context: context,
                                builder: (context) => UpdateAccountDialog(
                                      account: accounts[i],
                                    )),
                          ),
                          SlidableAction(
                              icon: Icons.delete_forever,
                              autoClose: true,
                              foregroundColor: Colors.red,
                              backgroundColor: ctx.appBarTheme.backgroundColor!,
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
                          makeFavourite: () => DatabaseHelper().markFavourite(
                              accounts[i], accounts[i].isFavorite),
                        ),
                      ));
        });
  }
}
