import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/inventory/models/inventory_item.dart';
import 'package:vhbc_broker_app/features/inventory/presentation/widgets/inventory_project_chips.dart';
import 'package:vhbc_broker_app/features/inventory/presentation/widgets/inventory_status_filter_bar.dart';
import 'package:vhbc_broker_app/features/inventory/presentation/widgets/lot_size_filter_bar.dart';
import 'package:vhbc_broker_app/features/inventory/presentation/widgets/lot_size_filter_sheet.dart';

void main() {
  testWidgets('InventoryProjectChips displays project choice chips and handles taps',
      (WidgetTester tester) async {
    String selectedProject = 'all';

    final testOptions = [
      const InventoryProjectOption(
        id: 'all',
        label: 'All Projects',
        name: 'All Projects',
      ),
      const InventoryProjectOption(
        id: 'MVLC',
        label: 'MVLC',
        name: 'MVLC',
      ),
      const InventoryProjectOption(
        id: 'MSCC',
        label: 'MSCC',
        name: 'MSCC',
      ),
      const InventoryProjectOption(
        id: 'ERHD',
        label: 'ERHD',
        name: 'ERHD',
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return InventoryProjectChips(
                selectedProjectId: selectedProject,
                options: testOptions,
                onSelectProject: (id) {
                  setState(() {
                    selectedProject = id;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify all project chips are rendered
    expect(find.text('All Projects'), findsOneWidget);
    expect(find.text('MVLC'), findsOneWidget);
    expect(find.text('MSCC'), findsOneWidget);
    expect(find.text('ERHD'), findsOneWidget);

    // Tap 'MVLC' project chip
    await tester.tap(find.text('MVLC'));
    await tester.pumpAndSettle();

    expect(selectedProject, equals('MVLC'));
  });

  testWidgets('InventoryStatusFilterBar displays status pills and counts',
      (WidgetTester tester) async {
    String selectedStatus = 'all';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return InventoryStatusFilterBar(
                selectedStatus: selectedStatus,
                availableCount: 42,
                reservedCount: 15,
                soldCount: 120,
                totalCount: 177,
                onStatusSelected: (status) {
                  setState(() {
                    selectedStatus = status;
                  });
                },
              );
            },
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Available'), findsOneWidget);
    expect(find.text('42'), findsOneWidget);
    expect(find.text('Reserved'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('Sold'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);
    expect(find.text('All Lots'), findsOneWidget);
    expect(find.text('177'), findsOneWidget);

    await tester.tap(find.text('Available'));
    await tester.pumpAndSettle();

    expect(selectedStatus, equals('available'));
  });

  testWidgets('LotSizeFilterBar renders size presets and handles selection',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    double? minSize;
    double? maxSize;
    bool customOpened = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return LotSizeFilterBar(
                selectedMin: minSize,
                selectedMax: maxSize,
                onSelectPreset: (min, max, label) {
                  setState(() {
                    minSize = min;
                    maxSize = max;
                  });
                },
                onOpenCustomFilter: () {
                  customOpened = true;
                },
              );
            },
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify initial visible preset options are rendered
    expect(find.text('Size'), findsOneWidget);
    expect(find.text('All Sizes'), findsOneWidget);
    expect(find.text('< 200 sqm'), findsOneWidget);
    expect(find.text('200 - 300 sqm'), findsOneWidget);

    // Tap '200 - 300 sqm'
    await tester.tap(find.text('200 - 300 sqm'));
    await tester.pumpAndSettle();

    expect(minSize, equals(200.0));
    expect(maxSize, equals(300.0));

    // Scroll to Custom... and tap
    await tester.scrollUntilVisible(
      find.text('Custom...'),
      50.0,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Custom...'), findsOneWidget);
    await tester.tap(find.text('Custom...'));
    await tester.pumpAndSettle();

    expect(customOpened, isTrue);
  });

  testWidgets('LotSizeFilterSheet allows dialing in size and applying',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    double? appliedMin;
    double? appliedMax;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LotSizeFilterSheet(
            initialMin: 150,
            initialMax: 450,
            onApply: (min, max, label) {
              appliedMin = min;
              appliedMax = max;
            },
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify UI elements exist
    expect(find.text('Filter Lot Size Range'), findsOneWidget);
    expect(find.text('QUICK PRESETS'), findsOneWidget);
    expect(find.text('Apply Size Filter'), findsOneWidget);

    // Tap quick preset '< 200 sqm'
    await tester.tap(find.text('< 200 sqm'));
    await tester.pumpAndSettle();

    // Tap Apply
    await tester.tap(find.text('Apply Size Filter'));
    await tester.pumpAndSettle();

    expect(appliedMin, isNull);
    expect(appliedMax, equals(200.0));
  });
}

