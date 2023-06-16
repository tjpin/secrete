// ignore_for_file: library_prefixes

import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/constants/widgets/gradient_card.dart';
import 'package:secrete/core.dart';
import 'package:secrete/models/card.dart' as CD;

class CardDialogContainer extends ConsumerStatefulWidget {
  const CardDialogContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardDialogContainerState();
}

class _CardDialogContainerState extends ConsumerState<CardDialogContainer> {
  final bankNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cvvNumberController = TextEditingController();
  final monthDateController = TextEditingController();
  final yearDateController = TextEditingController();
  CardType _defaultCardType = CardType.defaultCard;
  String expiryDate = '00 / 00';

  bool validateFields() {
    if (bankNameController.text.isNotEmpty &&
        cardNumberController.text.isNotEmpty &&
        cvvNumberController.text.isNotEmpty &&
        monthDateController.text.isNotEmpty &&
        yearDateController.text.isNotEmpty &&
        expiryDate != '00 / 00') return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    const cid = Uuid();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 300),
        decoration: BoxDecoration(
            color: ctx.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
                label: Text(
              "New Card",
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
                Text(expiryDate),
                const Spacer(),
                expiryDateInput(ctx, 'MM', monthDateController, (v) {}),
                const Text("/").addHPadding(15),
                expiryDateInput(ctx, 'YY', yearDateController, (v) {
                  setState(() {
                    expiryDate =
                        monthDateController.text + yearDateController.text;
                  });
                }),
              ],
            ),
            hsizer(5),
            label(ctx, 'Card Type'),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                  value: _defaultCardType,
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
                      child:
                          buildRowItem(ctx, CardType.mastercard, 'MasterCard'),
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
                      value: CardType.amex,
                      child: buildRowItem(ctx, CardType.amex, 'American Express'),
                    ),
                    DropdownMenuItem(
                      value: CardType.maestro,
                      child: buildRowItem(ctx, CardType.maestro, 'Maestro'),
                    ),
                  ],
                  onChanged: (t) => setState(() => _defaultCardType = t!)),
            ),
            hsizer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: ctx.textTheme.bodySmall!.copyWith(color: Colors.red),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (validateFields()) {
                      CD.CardData card = CD.CardData()
                        ..id = cid.v4()
                        ..name = bankNameController.text
                        ..cardNumber = int.parse(cardNumberController.text)
                        ..cardCvv = int.parse(cvvNumberController.text)
                        ..cardType = _defaultCardType
                        ..expiryDate = expiryDate;
                      DatabaseHelper.getCards().put(card.id, card);
                      Navigator.pop(context);
                      successToast('${card.name} added Successifully');
                      return;
                    }
                    errorToast("All fields are required");
                  },
                  child: Text(
                    "Add",
                    style:
                        ctx.textTheme.bodySmall!.copyWith(color: Colors.green),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

extension Join on String {
  String join(String n) {
    return this + n;
  }
}

Widget buildRowItem(ThemeData ctx, CardType cardType, String label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        cardImage(cardType),
        height: 60,
      ),
      Text(
        label,
        style: ctx.textTheme.bodySmall,
      ),
    ],
  ).addVPadding(5);
}

Widget expiryDateInput(ThemeData ctx, String label,
        TextEditingController controller, Function textChanged) =>
    SizedBox(
      width: 60,
      child: TextField(
        maxLength: 2,
        onChanged: (v) => textChanged(v),
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: label,
            counterText: '',
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide:
                    BorderSide(color: ctx.colorScheme.error, width: 2))),
      ),
    );
