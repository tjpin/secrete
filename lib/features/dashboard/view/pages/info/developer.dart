import 'package:secrete/core.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperTab extends StatefulWidget {
  const DeveloperTab({super.key});

  @override
  State<DeveloperTab> createState() => _DeveloperTabState();
}

class _DeveloperTabState extends State<DeveloperTab> {
  List<String> licence = [];

  void getInstructions() async {
    final data = await rootBundle.loadString('assets/files/licence.txt');
    final List<String> licenceList = data.split('*').toList();
    setState(() {
      licence = licenceList;
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
          buildLinkRow(
              ctx,
              Icons.coffee,
              () {},
              "Buy me a coffee",
              dotenv.env['PATREON_LINK'].toString(),
              'assets/images/paypal.png'),
          buildLinkRow(ctx, Icons.star, () {}, "Follow me on Github",
              dotenv.env['GITHUB_URL'].toString(), 'assets/images/github.png'),
          buildLinkRow(ctx, Icons.code, () {}, "Source Code",
              dotenv.env['SOURCE_CODE'].toString(), 'assets/images/github.png'),
          Divider(
            height: 10,
            color: ctx.iconTheme.color,
          ),
          Text(
            "MIT License",
            style:
                ctx.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ).addVPadding(10),
          Expanded(
            child: ListView.builder(
                itemCount: licence.length,
                itemBuilder: (context, i) => Text(
                      licence[i],
                      softWrap: true,
                      style: ctx.textTheme.bodySmall,
                    )).addVPadding(10),
          )
        ],
      ),
    );
  }
}

Widget buildLinkRow(ThemeData ctx, IconData icon, VoidCallback onTap,
    String label, String url, String image) {
  return Row(
    children: [
      ColorFiltered(
          colorFilter: const ColorFilter.linearToSrgbGamma(),
          child: Image.asset(image, fit: BoxFit.contain, width: 60)),
      wsizer(20),
      TextButton.icon(
          icon: Icon(
            icon,
            color: ctx.iconTheme.color,
          ),
          onPressed: () {
            launchUrl(Uri.parse(url));
          },
          label: Text(
            label,
            style: ctx.textTheme.bodySmall,
          )),
    ],
  );
}
