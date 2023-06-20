import 'package:secrete/commons/helpers/account_bottomsheet.dart';
import 'package:secrete/core.dart';

class AccountSearchPage extends StatefulWidget {
  static const routeName = "accountSearch/";
  const AccountSearchPage({super.key});

  @override
  State<AccountSearchPage> createState() => _AccountSearchPageState();
}

class _AccountSearchPageState extends State<AccountSearchPage> {
  List<Account> allAccounts =
      List<Account>.from(DatabaseHelper.getAccount().values);
  List<Account> filteredAccounts = [];
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.removeListener(() {});
    super.dispose();
  }

  @override
  didChangeDependencies() {
    FocusScope.of(context).requestFocus(_focusNode);
    super.didChangeDependencies();
  }

  void _filterAccounts(String v) {
    setState(() {
      filteredAccounts = allAccounts
          .where((account) =>
              account.name!.toLowerCase().contains(v.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: ctx.iconTheme.color)),
        title: InputField(
          style: ctx.textTheme.bodyMedium!,
          controller: _searchController,
          focusNode: _focusNode,
          borderRadius: 25,
          hasBorder: true,
          cpadding: 30,
          icon: Icon(
            Icons.search,
            color: ctx.iconTheme.color,
          ),
          textChanged: (v) => _filterAccounts(v),
        ),
      ),
      body: filteredAccounts.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: const Text("Search account..."),
            )
          : ListView.builder(
              itemCount: filteredAccounts.length,
              itemBuilder: (context, i) {
                Account account = filteredAccounts[i];
                return AccountListTile(
                  account: filteredAccounts[i],
                  icon: const Text(""),
                  onAction: () => viewDetails(context, ctx, account),
                  makeFavourite: () {},
                );
              }),
    );
  }
}
