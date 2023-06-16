import 'package:secrete/core.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  List<String> about = [];

  void getInstructions() async {
    final data = await rootBundle.loadString('assets/files/about.txt');
    final List<String> aboutList = data.split('*').toList();
    setState(() {
      about = aboutList;
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
            "About This App!",
            style:
                ctx.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ).addVPadding(10),
          Expanded(
            child: ListView.builder(
                itemCount: about.length,
                itemBuilder: (context, i) => Text(
                      about[i],
                      softWrap: true,
                      style: ctx.textTheme.bodySmall,
                    )).addVPadding(10),
          )
        ],
      ),
    );
  }
}
