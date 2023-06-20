// ignore_for_file: unused_field
import 'package:secrete/commons/widgets/label.dart';
import 'package:secrete/core.dart';
import 'package:secrete/models/indentification.dart';

class IdCardsDialog extends StatefulWidget {
  final Indentification? indentification;
  final bool? isForEdit;
  const IdCardsDialog(
      {super.key, this.indentification, this.isForEdit = false});

  @override
  State<IdCardsDialog> createState() => _IdCardsDialogState();
}

class _IdCardsDialogState extends State<IdCardsDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  // Focus Nodes
  final _dayNode = FocusNode();
  final _monthNode = FocusNode();
  final _yearNode = FocusNode();

  final _xdayNode = FocusNode();
  final _xmonthNode = FocusNode();
  final _xyearNode = FocusNode();

  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();

  final TextEditingController _xyearController = TextEditingController();
  final TextEditingController _xmonthController = TextEditingController();
  final TextEditingController _xdayController = TextEditingController();
  String _expiryDate = "";
  String _dateOfIssue = "";
  IdType _idType = IdType.other;
  static const uid = Uuid();

  bool inputsValidated() {
    return _nameController.text.isNotEmpty && _numberController.text.isNotEmpty;
  }

  void clearFields() {
    _nameController.clear();
    _descriptionController.clear();
    _numberController.clear();
    _dayController.clear();
    _monthController.clear();
    _yearController.clear();
    _xdayController.clear();
    _xmonthController.clear();
    _xyearController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _numberController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _xdayController.dispose();
    _xmonthController.dispose();
    _xyearController.dispose();

    // Focus Nodes Disposal
    _dayNode.dispose();
    _monthNode.dispose();
    _yearNode.dispose();
    _xdayNode.dispose();
    _xmonthNode.dispose();
    _xyearNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.isForEdit == true) {
      final idnt = widget.indentification!;
      _nameController.text = idnt.name;
      _numberController.text = idnt.number;
      _descriptionController.text = idnt.description!;
      if (idnt.dateOfIssue.toString().length >= 9) {
        _dayController.text = idnt.dateOfIssue!.substring(0, 2);
        _monthController.text = idnt.dateOfIssue!.substring(5, 7);
        _yearController.text = idnt.dateOfIssue!.substring(10);
      }
      if (idnt.expiryDate.toString().length >= 9) {
        _xdayController.text =
            idnt.expiryDate!.substring(0, 2); //"dd - mm - yyyy"
        _xmonthController.text = idnt.expiryDate!.substring(5, 7);
        _xyearController.text = idnt.expiryDate!.substring(10);
      }

      _expiryDate = idnt.expiryDate!;
      _dateOfIssue = idnt.dateOfIssue!;
      _idType = idnt.type;
      return;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
                avatar: Icon(
                  Icons.card_membership,
                  color: ctx.iconTheme.color,
                ),
                label: Text(
                  widget.isForEdit == true ? "Update Id" : 'Add Id',
                  style: ctx.textTheme.bodyMedium,
                )),
            hsizer(15),
            InputField(
              style: ctx.textTheme.bodyMedium!,
              hint: "name",
              maxLength: 30,
              controller: _nameController,
              textChanged: (_) {},
            ),
            hsizer(10),
            InputField(
              style: ctx.textTheme.bodyMedium!,
              hint: "Number",
              maxLength: 15,
              controller: _numberController,
              textChanged: (_) {},
            ),
            hsizer(10),
            InputField(
              style: ctx.textTheme.bodyMedium!,
              hint: "Description [OPTIONAL]",
              controller: _descriptionController,
              textChanged: (_) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectDateInput(ctx, 'DD', 2, _dayNode, _dayController,
                    (String v) {
                  if (v.length == 2) {
                    FocusScope.of(context).requestFocus(_monthNode);
                  }
                }),
                const Text("/").addHPadding(5),
                selectDateInput(ctx, 'MM', 2, _monthNode, _monthController,
                    (String v) {
                  if (v.length == 2) {
                    FocusScope.of(context).requestFocus(_yearNode);
                  }
                }),
                const Text("/").addHPadding(5),
                selectDateInput(ctx, 'YYYY', 4, _yearNode, _yearController,
                    (v) {
                  setState(() {
                    _dateOfIssue =
                        "${_dayController.text} - ${_monthController.text} - ${_yearController.text}";
                  });
                }),
              ],
            ),
            label(ctx, "Date of Issue"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectDateInput(ctx, 'DD', 2, _xdayNode, _xdayController,
                    (String v) {
                  if (v.length == 2) {
                    FocusScope.of(context).requestFocus(_xmonthNode);
                  }
                }),
                const Text("/").addHPadding(5),
                selectDateInput(ctx, 'MM', 2, _xmonthNode, _xmonthController,
                    (String v) {
                  if (v.length == 2) {
                    FocusScope.of(context).requestFocus(_xyearNode);
                  }
                }),
                const Text("/").addHPadding(5),
                selectDateInput(ctx, 'YYYY', 4, _xyearNode, _xyearController,
                    (v) {
                  setState(() {
                    _expiryDate =
                        "${_xdayController.text} / ${_xmonthController.text} / ${_xyearController.text}";
                  });
                }),
              ],
            ),
            label(ctx, "Expiry Date"),
            DropdownButton(
                value: _idType,
                items: [
                  DropdownMenuItem(
                    value: IdType.other,
                    child: Text("Other", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.idCard,
                    child: Text("ID Card", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.passport,
                    child: Text("Passport", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.drivingLicence,
                    child:
                        Text("Driving Licence", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.healthCard,
                    child: Text("Health Card", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.gatePass,
                    child: Text("Gate Pass", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.accessCard,
                    child: Text("Access Card", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.membership,
                    child: Text("Membership", style: ctx.textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: IdType.insuranceCard,
                    child:
                        Text("Insurance Card", style: ctx.textTheme.bodySmall),
                  ),
                ],
                onChanged: (type) {
                  setState(() {
                    _idType = type!;
                  });
                }),
            hsizer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SplashButton(
                    ctx: ctx,
                    label: 'Cancel',
                    color: Colors.red,
                    callBack: () {
                      Navigator.of(context).pop();
                      clearFields();
                    }),
                SplashButton(
                    ctx: ctx,
                    label: widget.isForEdit == true ? 'Update' : "Save",
                    color: Colors.green,
                    callBack: () {
                      final existingId = widget.indentification;
                      if (inputsValidated()) {
                        Indentification identity = Indentification(
                            id: widget.isForEdit == true
                                ? existingId!.id
                                : uid.v4(),
                            name: _nameController.text,
                            number: _numberController.text,
                            type: _idType)
                          ..description = _descriptionController.text
                          ..expiryDate =
                              "${_xdayController.text} - ${_xmonthController.text} - ${_xyearController.text}"
                          ..dateOfIssue =
                              "${_dayController.text} - ${_monthController.text} - ${_yearController.text}";
                        widget.isForEdit == true
                            ? DatabaseHelper().updateIndentification(identity)
                            : DatabaseHelper().addIndentification(identity);
                        widget.isForEdit == true
                            ? successToast("ID Data updated seccessifuly")
                            : successToast("ID Data added seccessifuly");
                        Navigator.pop(context);
                        return;
                      } else {
                        errorToast("Name & Number can't be empty");
                      }
                    }),
              ],
            )
          ],
        ),
      ).addAllPadding(20),
    );
  }
}

Widget selectDateInput(ThemeData ctx, String label, int ml, FocusNode fnode,
        TextEditingController controller, Function textChanged) =>
    SizedBox(
      width: 60,
      child: TextField(
        maxLength: ml,
        onChanged: (v) => textChanged(v),
        controller: controller,
        focusNode: fnode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15),
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
