import 'package:flutter_test/flutter_test.dart';
import 'package:locator_mobile/app/app.dart';
import 'package:locator_mobile/home/view/home.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
