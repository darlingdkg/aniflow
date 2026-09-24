import 'package:aniflow/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('public framework boots with placeholder content only', (
    tester,
  ) async {
    await tester.pumpWidget(const AniFlowApp());
    await tester.pump();
    await tester.pump();

    expect(find.byKey(const ValueKey('placeholder-home-tab')), findsOneWidget);

    await tester.tap(find.byType(NavigationDestination).at(1));
    await tester.pump();
    expect(
      find.byKey(const ValueKey('placeholder-search-tab')),
      findsOneWidget,
    );

    await tester.tap(find.byType(NavigationDestination).at(2));
    await tester.pump();
    expect(
      find.byKey(const ValueKey('placeholder-library-tab')),
      findsOneWidget,
    );

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pump();
    expect(
      find.byKey(const ValueKey('framework-personal-tab')),
      findsOneWidget,
    );
  });
}
