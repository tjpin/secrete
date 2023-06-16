import 'package:secrete/core.dart';

class PrivacyTab extends StatefulWidget {
  const PrivacyTab({super.key});

  @override
  State<PrivacyTab> createState() => _PrivacyTabState();
}

class _PrivacyTabState extends State<PrivacyTab> {
  List<String> policies = [];

  void getInstructions() async {
    final data = await rootBundle.loadString('assets/files/policies.txt');
    final List<String> policiesList = data.split('*').toList();
    setState(() {
      policies = policiesList;
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
            "Privacy Policy",
            style:
                ctx.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ).addVPadding(10),
          Expanded(
            child: ListView.builder(
                itemCount: policies.length,
                itemBuilder: (context, i) => Text(
                      policies[i],
                      softWrap: true,
                      style: ctx.textTheme.bodySmall,
                    )).addVPadding(10),
          )
        ],
      ),
    );
  }
}
