// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:hexcolor/hexcolor.dart';
import 'package:secrete/features/auth/controllers/auth_controller.dart';

import '../../core.dart';

class GradientCard extends ConsumerStatefulWidget {
  final String? cvv;
  final bool? cvvVisible;
  final VoidCallback? showCvv;
  final CardType? cardType;
  final String? bankName;
  final String? expiryDate;
  final String? cardNumber;
  final bool? isForDisplay;
  const GradientCard({
    super.key,
    this.cvv,
    this.cardType,
    this.bankName,
    this.cvvVisible,
    this.expiryDate,
    this.cardNumber,
    this.showCvv,
    this.isForDisplay = false,
  });

  @override
  ConsumerState<GradientCard> createState() => _GradientCardState();
}

class _GradientCardState extends ConsumerState<GradientCard> {
  String username = "";

  void updateUsername() {
    final auth = ref.read(authControllerProvider);
    final name = auth.getSavedUser().username ?? "";
    setState(() {
      username = name;
    });
  }

  @override
  initState() {
    updateUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);

    return Container(
      height: 200,
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            ctx.primaryColor,
            cardColor(widget.cardType ?? CardType.defaultCard)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              widget.bankName ?? "Card",
              style: ctx.textTheme.bodyMedium!,
            ),
          ),
          Positioned(
              top: 5,
              right: 10,
              child: Image.asset(
                cardImage(widget.cardType ?? CardType.defaultCard),
                fit: BoxFit.contain,
                height: 50,
                colorBlendMode: BlendMode.overlay,
              )),
          Positioned(
              top: 60,
              left: 20,
              child: Image.asset(
                'assets/images/chip.png',
                width: 50,
                fit: BoxFit.contain,
              )),
          Positioned(
              top: 60,
              left: 100,
              child: InkWell(
                onTap: widget.showCvv ?? () {},
                child: Chip(
                  backgroundColor: ctx.primaryColor,
                  label: Visibility(
                    visible: widget.cvvVisible ?? false,
                    replacement: Text(
                      'cvv',
                      style: ctx.textTheme.bodyMedium,
                    ),
                    child: Text(
                      widget.cvv ?? "Secured",
                      style: ctx.textTheme.bodyMedium!,
                    ).addHPadding(10),
                  ),
                ),
              )),
          Positioned(
              left: 8,
              top: 110,
              child: TextButton.icon(
                  onPressed: widget.cardNumber == null
                      ? () {}
                      : () {
                          Clipboard.setData(ClipboardData(
                              text: widget.cardNumber.toString()));
                          successToast("Card Number copied to clipboard");
                        },
                  icon: Icon(
                    Icons.copy,
                    size: 14,
                    fill: 0,
                    color: ctx.iconTheme.color,
                  ),
                  label: Text(
                    widget.cardNumber ??
                        "Keep your cards organized in one place",
                    style: ctx.textTheme.bodyMedium!.copyWith(
                        color:
                            ctx.textTheme.bodyMedium!.color!.withOpacity(0.7)),
                  ))),
          Positioned(
              bottom: 30,
              left: 20,
              child: Text(
                widget.expiryDate ?? "00/ 00",
                style: ctx.textTheme.bodySmall!.copyWith(
                    color: ctx.textTheme.bodyMedium!.color!.withOpacity(0.7)),
              )),
          Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                username.isEmpty ? "Username" : username,
                style: ctx.textTheme.bodySmall!.copyWith(
                    color: ctx.textTheme.bodyMedium!.color!.withOpacity(0.7)),
              )),
          widget.isForDisplay!
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: Image.asset(
                    "assets/images/mastercard.png",
                    fit: BoxFit.contain,
                    height: 50,
                  ))
              : const Text(""),
        ],
      ),
    );
  }
}

String cardImage(CardType type) {
  switch (type) {
    case CardType.visa:
      return 'assets/images/visa.png';
    case CardType.discover:
      return 'assets/images/discover.png';
    case CardType.mastercard:
      return 'assets/images/mastercard.png';
    case CardType.jcb:
      return 'assets/images/jcb.png';
    case CardType.amex:
      return 'assets/images/amex.png';
    case CardType.maestro:
      return 'assets/images/maestro.png';
    case CardType.paytime:
      return 'assets/images/paytime.png';
    case CardType.defaultCard:
      return 'assets/images/default-card.png';
  }
}

Color cardColor(CardType type) {
  switch (type) {
    case CardType.visa:
      return const Color.fromARGB(255, 0, 121, 219);
    case CardType.jcb:
      return const Color.fromARGB(255, 7, 93, 136);
    case CardType.mastercard:
      return HexColor('#F80707');
    case CardType.paytime:
      return Colors.cyan;
    case CardType.amex:
      return Colors.blue;
    case CardType.maestro:
      return Colors.red;
    case CardType.discover:
      return HexColor("#4B1219");
    default:
      return Colors.blueAccent;
  }
}

// enum CardType {
//   defaultCard,
//   visa,
//   mastercard,
//   discover,
//   paytime,
//   debit
// }