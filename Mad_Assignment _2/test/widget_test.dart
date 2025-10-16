// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_guide_app/main.dart';

void main() {
  testWidgets('App shows the Travel Guide title', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const TravelGuideApp());

    // Allow any async work to settle
    await tester.pumpAndSettle();

    // Verify the AppBar title is shown
    expect(find.text('Travel Guide'), findsOneWidget);
  });
}
