import 'package:secrete/constants/widgets/gradient_card.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';
import 'package:secrete/features/dashboard/view/pages/cards/update_card.dart';

import 'helpers/card_dislog.dart';

class BankCardsPage extends ConsumerStatefulWidget {
  const BankCardsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BankCardsPageState();
}

class _BankCardsPageState extends ConsumerState<BankCardsPage> {
  bool cvvVisible = false;
  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.getCards().listenable(),
      builder: (context, box, _) {
        List<CardData> cards = List<CardData>.from(box.values);
        return Stack(
          children: [
            cards.isEmpty
                ? Center(
                    child: TextButton.icon(
                        onPressed: () => addCardDialog(context),
                        style: ctx.textButtonTheme.style!.copyWith(
                            backgroundColor: MaterialStateProperty.all(
                                ctx.appBarTheme.backgroundColor)),
                        icon: Icon(
                          Icons.add,
                          color: ctx.iconTheme.color,
                        ),
                        label: Text(
                          "Add your first Card",
                          style: ctx.textTheme.bodySmall,
                        )),
                  )
                : ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, i) => Slidable(
                      direction: Axis.horizontal,
                      startActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (_) {
                            confirmDelete(context,
                                () => DatabaseHelper().deleteCard(cards[i]));
                          },
                          icon: Icons.delete,
                          foregroundColor: Colors.red,
                          label: 'Delete',
                          backgroundColor: ctx.appBarTheme.backgroundColor!,
                        ),
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(
                                context: context,
                                builder: (context) => UpdateCardDialog(
                                      card: cards[i],
                                    ));
                          },
                          icon: Icons.edit,
                          foregroundColor: ctx.iconTheme.color,
                          label: 'Update',
                          backgroundColor: ctx.appBarTheme.backgroundColor!,
                        ),
                      ]),
                      child: GradientCard(
                        isForDisplay: false,
                        cvvVisible: cvvVisible,
                        showCvv: () => setState(() {
                          cvvVisible = !cvvVisible;
                        }),
                        cvv: cards[i].cardCvv.toString(),
                        bankName: cards[i].name,
                        cardType: cards[i].cardType,
                        cardNumber: cards[i].cardNumber.toString(),
                        expiryDate:
                            "${cards[i].expiryDate!.substring(0, 2)} / ${cards[i].expiryDate!.substring(2, 4)}",
                      ).addVPadding(5),
                    ),
                  ),
            Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () => addCardDialog(context),
                  child: Icon(
                    Icons.payment,
                    color: ctx.iconTheme.color,
                  ),
                )),
          ],
        );
      },
    );
  }

  RichText doubleText(ThemeData ctx, String name, String info) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: name,
          style: ctx.textTheme.bodySmall!.copyWith(
              color: ctx.textTheme.bodySmall!.color!.withOpacity(0.5))),
      TextSpan(text: info, style: ctx.textTheme.bodySmall),
    ]));
  }
}
