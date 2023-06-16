// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:secrete/core.dart';
import 'package:secrete/features/auth/view/user_views/new_userview.dart';

import 'package:secrete/main.dart' as app;

void main() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    group('registration and login test', () {
        testWidgets('verify registration', (tester) async {
            app.main();
            await tester.pumpAndSettle();
            await tester.enterText(find.byKey(Key('usernameKey')), 'chairman');
            await tester.enterText(find.byKey(Key('pincodeKey')), '123456');
            await tester.tap(find.byType(SplashButton));

            await tester.pumpAndSettle();
            expect(find.byType(NewSignup), findsOneWidget);

        });
    });
}