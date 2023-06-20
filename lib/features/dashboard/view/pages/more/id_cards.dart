// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'package:secrete/features/dashboard/view/pages/more/widgets/id_cards_dialog.dart';
import 'package:secrete/models/indentification.dart';

import 'helpers/widget_helpers.dart';
import 'widgets/list_card.dart';

class IdCardsPage extends ConsumerStatefulWidget {
  const IdCardsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IdCardsPageState();
}

class _IdCardsPageState extends ConsumerState<IdCardsPage> {
  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ValueListenableBuilder(
        valueListenable:
            DatabaseHelper.getCurrentIdentificationBox().listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(
              child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => const IdCardsDialog());
                  },
                  icon: Icon(
                    Icons.add_card,
                    color: ctx.iconTheme.color,
                  ),
                  label: Text(
                    'Add first Id',
                    style: ctx.textTheme.bodyMedium,
                  )),
            );
          } else {
            List<Indentification> identities = box.values.toList();
            return ListView.builder(
                itemCount: identities.length,
                itemBuilder: (_, i) {
                  final identity = identities[i];
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                          backgroundColor: ctx.primaryColor,
                          onPressed: (_) => showDialog(
                              context: context,
                              builder: (_) => IdCardsDialog(
                                    isForEdit: true,
                                    indentification: identity,
                                  )),
                          icon: Icons.edit,
                          label: "Update",
                          foregroundColor: ctx.iconTheme.color),
                      SlidableAction(
                        onPressed: (_) {
                          DatabaseHelper().deleteIndentification(identity);
                          successToast("${identity.name} deleted successifuly");
                        },
                        icon: Icons.delete,
                        label: "Delete",
                        backgroundColor: ctx.primaryColor,
                        foregroundColor: Colors.red,
                      ),
                    ]),
                    child: ListCard(
                      cardHeight: 70,
                      bgColor: ctx.scaffoldBackgroundColor,
                      icon: buildIcon(identity.type),
                      title: identity.name,
                      subtitle: identity.number,
                      onTap: () {
                        showDetails(ctx, context, identity);
                      },
                    ),
                  );
                });
          }
        });
  }
}
