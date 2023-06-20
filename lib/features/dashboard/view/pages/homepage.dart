import 'dart:math';

import 'package:pie_chart/pie_chart.dart';
import 'package:secrete/constants/widgets/analysis_card.dart';
import 'package:secrete/constants/widgets/gradient_card.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/dashboard/core.dart';

CardType randomCardType(int i) {
  switch (i) {
    case 1:
      return CardType.jcb;
    case 2:
      return CardType.mastercard;
    case 3:
      return CardType.visa;
    case 4:
      return CardType.paytime;
    case 5:
      return CardType.discover;
    case 6:
      return CardType.amex;
    case 7:
      return CardType.maestro;
    default:
      return CardType.defaultCard;
  }
}

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final random = Random();
    final ctx = Theme.of(context);
    final ctl = ref.watch(databseAccountControllerProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientCard(
            isForDisplay: true,
            cardType: randomCardType(random.nextInt(7)),
          ),
          hsizer(20),
          Chip(
              label: Text(
            "Account Analysis",
            style: ctx.textTheme.bodyMedium,
          )),
          hsizer(10),
          Card(
            child: Column(
              children: [
                AnalysisCard(
                  title: "Added Accounts",
                  count: ctl.dbProvider.accountCounts().$1.toString(),
                  icon: Icons.add,
                ),
                AnalysisCard(
                  title: "Imported Accounts",
                  count: ctl.dbProvider.accountCounts().$2.toString(),
                  icon: Icons.import_export,
                ),
                AnalysisCard(
                  title: "Favorite Accounts",
                  count: ctl.dbProvider.accountCounts().$3.toString(),
                  icon: Icons.favorite,
                ),
                AnalysisCard(
                  title: "Wifi Accounts",
                  count: ctl.dbProvider.accountCounts().$4.toString(),
                  icon: Icons.favorite,
                ),
                AnalysisCard(
                  title: "Saved IDs",
                  count: ctl.dbProvider.accountCounts().$5.toString(),
                  icon: Icons.favorite,
                ),
              ],
            ).addAllPadding(10),
          ),
          hsizer(20),
          PieChart(
              chartValuesOptions: const ChartValuesOptions(
                  showChartValues: false, showChartValuesInPercentage: true),
              colorList: [
                Colors.blue,
                Colors.teal,
                Colors.deepOrange,
                Colors.blue[900]!,
                Colors.deepPurple
              ],
              chartRadius: 150,
              emptyColor: Colors.black,
              dataMap: {
                'added':
                    double.parse(ctl.dbProvider.accountCounts().$1.toString()),
                'imported':
                    double.parse(ctl.dbProvider.accountCounts().$2.toString()),
                'favorite':
                    double.parse(ctl.dbProvider.accountCounts().$3.toString()),
                'Wi-Fi':
                    double.parse(ctl.dbProvider.accountCounts().$4.toString()),
                'IDs':
                    double.parse(ctl.dbProvider.accountCounts().$5.toString()),
              }),
        ],
      ),
    );
  }
}
