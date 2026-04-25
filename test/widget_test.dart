// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:game_flutter/app/password_game_app.dart';

void main() {
  testWidgets('renders the password game screen', (WidgetTester tester) async {
    await tester.pumpWidget(const PasswordGameApp());

    expect(find.text('The Password Game'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create password'), findsOneWidget);
    expect(find.textContaining('Rule 1 of 16'), findsOneWidget);
    expect(
      find.textContaining('Rule 1: At least 5 characters'),
      findsOneWidget,
    );
  });
}
