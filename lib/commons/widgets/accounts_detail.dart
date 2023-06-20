import '../../core.dart';

class AccountDetailField extends StatelessWidget {
  final String label;
  const AccountDetailField({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return TextField(
      readOnly: true,
      style: ctx.textTheme.bodyMedium!.copyWith(fontSize: 16),
      controller: TextEditingController(text: label),
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: label));
                successToast("Copied to clipboard");
              },
              iconSize: 15,
              icon: Icon(
                Icons.copy,
                color: ctx.iconTheme.color,
              )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ctx.iconTheme.color!.withOpacity(0.2))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ctx.iconTheme.color!.withOpacity(0.2)))),
    );
  }
}