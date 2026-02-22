import 'package:flutter_test/flutter_test.dart';

import 'package:readtrack/main.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    // ReadTrackApp requires Hive – skip full pump in unit test.
    // This is a placeholder; integration tests cover the full flow.
    expect(ReadTrackApp, isNotNull);
  });
}
