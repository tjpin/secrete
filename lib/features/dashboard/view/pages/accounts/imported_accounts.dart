// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';

class ImportedAccounts extends ConsumerStatefulWidget {
  const ImportedAccounts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddedAccountsState();
}

class _AddedAccountsState extends ConsumerState<ImportedAccounts> {
  List<Account> importedAccounts = [];
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    final ctl = ref.watch(databseAccountControllerProvider);
    return ValueListenableBuilder(
        valueListenable: DatabaseHelper.getAccount().listenable(),
        builder: (context, box, _) {
          importedAccounts = List<Account>.from(box.values)
              .where((account) => account.isImported == true)
              .toList();
          return importedAccounts.isEmpty
              ? Center(
				child: MaterialButton(
					onPressed: () => ctl.importAccounts(ctl), 
					child: const Text("Import Accounts"),
				),)
              : ListView.builder(
                  itemCount: importedAccounts.length,
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
                                      account: importedAccounts[i],
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
                                      .deleteAccount(importedAccounts[i]))),
                        ]),
                        child: AccountListTile(
                          account: importedAccounts[i],
                          onAction: () =>
                              viewDetails(context, ctx, importedAccounts[i]),
                          makeFavourite: () => DatabaseHelper().markFavourite(
                              importedAccounts[i], importedAccounts[i].isFavorite),
                        ),
                      ));
        });
  }
}
