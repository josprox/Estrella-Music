import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/ui/auth/cloud_mode_choice_screen.dart';

void main() {
  testWidgets('CloudModeChoiceScreen renders in a wide desktop viewport',
      (tester) async {
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: CloudModeChoiceScreen(
          onKeepLocal: () {},
          onChooseCloud: () {},
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(Icons.headphones_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
