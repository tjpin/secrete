// import 'package:path_provider/path_provider.dart';
import 'package:secrete/core.dart';
import 'package:secrete/utils/themes.dart';
import 'database/constants/db_constants.dart';
import 'features/auth/view/pin_reset.dart';
import 'features/dashboard/core.dart';
import 'features/settings/settings.dart';
import 'models/themeset.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDatabase();

  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tid = Uuid();
    return ValueListenableBuilder(
      valueListenable: DatabaseHelper.getCurrentTheme().listenable(),
      builder: (context, theme, child) {
        if (theme.isEmpty) {
          ThemeSet data = ThemeSet(id: tid.v4(), isLightTheme: true);
          DatabaseHelper.getCurrentTheme().put(data.id, data);
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.values.first.isLightTheme ? lightTheme() : darkTheme(),
          darkTheme: darkTheme(),
          home: const Scaffold(
            body: LoginScreen(),
          ),
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            Dashboard.routeName: (context) => const Dashboard(),
            SecurityQuestionsScreen.routeName: (context) =>
                const SecurityQuestionsScreen(),
            AccountSearchPage.routeName: (context) => const AccountSearchPage(),
            SettingsPage.routeName: (context) => const SettingsPage(),
            PinResetScreen.routeName: (context) => const PinResetScreen(),
          },
        );
      },
    );
  }
}
