import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$FrameAddon',
    () {
      final deviceSetting = DeviceSetting.firstAsSelected(
        devices: [
          Apple.iPhone12,
          Apple.iPhone13,
          Apple.iPhone13Mini,
        ],
      );

      final noFrame = NoFrame();
      final deviceFrame = DefaultDeviceFrame(setting: deviceSetting);
      final widgetbookFrame = WidgetbookFrame(setting: deviceSetting);

      final setting = FrameSetting.firstAsSelected(
        frames: [
          noFrame,
          deviceFrame,
          widgetbookFrame,
        ],
      );
      final addon = FrameAddon(
        setting: setting,
      );

      testWidgets(
        'can access $Frame via the context',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            expect: (context) => expect(
              context.frame,
              equals(noFrame),
            ),
          );
        },
      );

      testWidgets(
        'can activate a $Frame',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: (context) async => addon.onChanged(
              context,
              setting.copyWith(
                activeFrame: deviceFrame,
              ),
            ),
            expect: (context) => expect(
              context.frame,
              equals(deviceFrame),
            ),
          );
        },
      );

      testWidgets(
        'can activate $Frame via Widget',
        (WidgetTester tester) async {
          await testAddon(
            tester: tester,
            addon: addon,
            act: (context) async {
              final dropdownFinder = find.byType(DropdownMenu<Frame>);
              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'Widgetbook Frame',
              );
              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (context) => expect(
              context.frame,
              equals(widgetbookFrame),
            ),
          );
        },
      );
    },
  );
}
