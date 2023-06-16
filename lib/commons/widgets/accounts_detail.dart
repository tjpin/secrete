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
      style: ctx.textTheme.bodyMedium,
      controller: TextEditingController(text: label),
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: label));
                successToast("Copied to clipboard");
              },
              icon: Icon(
                Icons.copy,
                color: ctx.iconTheme.color,
              )),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}