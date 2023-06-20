import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';
import 'package:secrete/models/indentification.dart';

IconData buildIcon(IdType type) {
  switch (type) {
    case IdType.drivingLicence:
      return Icons.local_taxi;
    case IdType.idCard:
      return Icons.badge_outlined;
    case IdType.membership:
      return Icons.card_membership;
    case IdType.healthCard:
      return Icons.medical_information_outlined;
    case IdType.accessCard:
      return Icons.assignment_ind_outlined;
    case IdType.insuranceCard:
      return Icons.co_present_rounded;
    case IdType.passport:
      return Icons.chrome_reader_mode_outlined;
    default:
      return Icons.assignment_outlined;
  }
}

showDetails(
    ThemeData ctx, BuildContext context, Indentification identity) async {
  await showModalBottomSheet(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                  label: Text(
                identity.name,
                style: ctx.textTheme.bodySmall,
              )),
              label(ctx, 'Number').addVPadding(10),
              itemDetailCard(ctx, identity.number, identity.number),
              label(ctx, 'Description').addVPadding(10),
              itemDetailCard(ctx, identity.description!, "Description"),
              label(ctx, 'Date of Issue').addVPadding(10),
              itemDetailCard(ctx, identity.dateOfIssue!, identity.dateOfIssue!),
              label(ctx, 'Expiry Date').addVPadding(10),
              itemDetailCard(ctx, identity.expiryDate!, identity.expiryDate!),
            ],
          ),
        ).addAllPadding(15);
      });
}

Widget itemDetailCard(ThemeData ctx, String title, String titleType) {
  return TextField(
    readOnly: true,
    controller: TextEditingController(text: title),
    decoration: InputDecoration(
      constraints: const BoxConstraints(maxHeight: 30),
      suffix: IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: title));
            successToast("$titleType copied to clipboard");
          },
          icon: Icon(
            Icons.copy,
            color: ctx.iconTheme.color,
            size: 16,
          )),
    ),
  );
}
