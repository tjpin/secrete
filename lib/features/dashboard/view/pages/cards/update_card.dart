import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';

import 'newcard_dialog.dart';

class UpdateCardDialog extends ConsumerStatefulWidget {
  final CardData card;
  const UpdateCardDialog({required this.card, Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateCardDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends ConsumerState<UpdateCardDialog> {
  late TextEditingController bankNameController;
  late TextEditingController cardNumberController;
  late TextEditingController cvvNumberController;
  late TextEditingController monthDateController;
  late TextEditingController yearDateController;
  late CardType newCardType;
  late String newExpiryDate;
  var favoritedValue = false;

  final n1Node = FocusNode();
  final n2Node = FocusNode();

  void clearFields() {
    bankNameController.clear();
    cardNumberController.clear();
    cvvNumberController.clear();
    monthDateController.clear();
    yearDateController.clear();
  }

  bool validateInputs(BuildContext ctx) {
    if (bankNameController.text.isEmpty || cardNumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    newCardType = widget.card.cardType!;
    newExpiryDate = widget.card.expiryDate!;
    bankNameController = TextEditingController(text: widget.card.name);
    cardNumberController =
        TextEditingController(text: widget.card.cardNumber.toString());
    cvvNumberController =
        TextEditingController(text: widget.card.cardCvv.toString());
    monthDateController =
        TextEditingController(text: widget.card.expiryDate!.substring(0, 2));
    yearDateController =
        TextEditingController(text: widget.card.expiryDate!.substring(2, 4));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = Theme.of(context);

    return Dialog(
      backgroundColor: ctx.primaryColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: size.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ctx.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                  label: Text(
                "Update ${widget.card.name}",
                style: ctx.textTheme.bodyMedium,
              )),
              label(ctx, 'Bank Name'),
              InputField(
                  hint: '',
                  textChanged: (_) {},
                  style: ctx.textTheme.bodyMedium!,
                  controller: bankNameController),
              hsizer(5),
              label(ctx, 'Card Number'),
              InputField(
                  hint: '',
                  textChanged: (_) {},
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  style: ctx.textTheme.bodyMedium!,
                  controller: cardNumberController),
              hsizer(5),
              label(ctx, 'CVV'),
              InputField(
                  hint: '',
                  textChanged: (_) {},
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  style: ctx.textTheme.bodyMedium!,
                  controller: cvvNumberController),
              hsizer(5),
              label(ctx, 'Expiry Date'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.card.expiryDate.toString()),
                  const Spacer(),
                  expiryDateInput(
                      ctx, 'MM', n1Node, monthDateController, (v) {}),
                  const Text("/").addHPadding(15),
                  expiryDateInput(ctx, 'YY', n2Node, yearDateController, (v) {
                    setState(() {
                      newExpiryDate =
                          "${monthDateController.text}${yearDateController.text}";
                    });
                  }),
                ],
              ),
              hsizer(5),
              label(ctx, 'Card Type'),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                    value: newCardType,
                    items: [
                      DropdownMenuItem(
                        value: CardType.defaultCard,
                        child: buildRowItem(ctx, CardType.defaultCard, 'Other'),
                      ),
                      DropdownMenuItem(
                        value: CardType.visa,
                        child: buildRowItem(ctx, CardType.visa, 'Visa'),
                      ),
                      DropdownMenuItem(
                        value: CardType.mastercard,
                        child: buildRowItem(
                            ctx, CardType.mastercard, 'MasterCard'),
                      ),
                      DropdownMenuItem(
                        value: CardType.jcb,
                        child: buildRowItem(ctx, CardType.jcb, 'JCB'),
                      ),
                      DropdownMenuItem(
                        value: CardType.discover,
                        child: buildRowItem(ctx, CardType.discover, 'Discover'),
                      ),
                      DropdownMenuItem(
                        value: CardType.paytime,
                        child: buildRowItem(ctx, CardType.paytime, 'Paytime'),
                      ),
                      DropdownMenuItem(
                        value: CardType.maestro,
                        child: buildRowItem(ctx, CardType.maestro, 'Maestro'),
                      ),
                      DropdownMenuItem(
                        value: CardType.amex,
                        child: buildRowItem(
                            ctx, CardType.amex, 'American Express'),
                      ),
                    ],
                    onChanged: (t) => setState(() => newCardType = t!)),
              ),
              hsizer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style:
                          ctx.textTheme.bodySmall!.copyWith(color: Colors.red),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      CardData card = CardData()
                        ..id = widget.card.id
                        ..name = bankNameController.text
                        ..cardNumber = int.parse(cardNumberController.text)
                        ..cardCvv = int.parse(cvvNumberController.text)
                        ..cardType = newCardType
                        ..expiryDate = newExpiryDate;
                      DatabaseHelper.getCards().put(card.id, card);
                      Navigator.pop(context);
                      successToast('${card.name} updated Successifully');
                    },
                    child: Text(
                      "Update",
                      style: ctx.textTheme.bodySmall!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextButton dialogButton(
    ThemeData ctx, String lable, IconData icon, Function callBack) {
  return TextButton.icon(
      style: ctx.textButtonTheme.style,
      onPressed: () => callBack(),
      icon: Icon(icon),
      label: Text(
        lable,
        style: ctx.textTheme.bodySmall,
      ));
}
