import 'package:secrete/core.dart';

class HelpTab extends StatefulWidget {
  const HelpTab({super.key});

  @override
  State<HelpTab> createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> {
  List<String> instructions = [];

  void getInstructions() async {
    final data = await rootBundle.loadString('assets/files/instructions.txt');
    final List<String> instructionsList = data.split('*').toList();
    setState(() {
      instructions = instructionsList;
    });
  }

  @override
  void initState() {
    getInstructions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ctx = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How to import browser accounts?",
            style:
                ctx.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ).addVPadding(10),
          Expanded(
            child: ListView.builder(
                itemCount: instructions.length,
                itemBuilder: (context, i) => Text(
                      instructions[i],
                      softWrap: true,
                      style: ctx.textTheme.bodySmall,
                    )).addVPadding(10),
          )
        ],
      ),
    );
  }
}
