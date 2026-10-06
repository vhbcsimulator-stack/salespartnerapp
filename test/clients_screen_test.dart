import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/clients/presentation/clients_screen.dart';
import 'package:vhbc_broker_app/features/clients/presentation/widgets/client_detail_sheet.dart';

void main() {
  setUp(() {
    SupabaseService.clearClientsCache();
  });

  testWidgets('ClientsScreen renders header, metrics, search, and empty state when no clients',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ClientsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify header
    expect(find.text('Clients'), findsOneWidget);
    expect(find.text('VHBC BROKER PORTAL'), findsOneWidget);

    // Verify search bar
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search client name, mobile, email...'), findsOneWidget);

    // Verify metrics cards
    expect(find.text('TOTAL ACTIVE'), findsOneWidget);
    expect(find.text('HOT LEADS'), findsOneWidget);
    expect(find.text('ACTIVE HOLDS'), findsOneWidget);
    expect(find.text('TURNOVER'), findsOneWidget);

    // Verify empty state is displayed when mock data is cleared
    expect(find.text('No clients yet'), findsOneWidget);
    expect(find.text('+ Add First Client'), findsOneWidget);
  });

  testWidgets('ClientsScreen Add Client Modal adds lead to list', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ClientsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap floating add button
    final addBtn = find.text('+ Add Client');
    expect(addBtn, findsOneWidget);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    // Verify modal appeared
    expect(find.text('Register New Buyer Lead'), findsOneWidget);

    // Fill form
    final textFields = find.byType(TextFormField);
    expect(textFields, findsNWidgets(3));

    await tester.enterText(textFields.at(0), 'Dr. Alejandro Ramos');
    await tester.enterText(textFields.at(1), '+63 917 111 2233');
    await tester.enterText(textFields.at(2), 'Looking for 300sqm lot in Phase 2');
    await tester.pumpAndSettle();

    // Tap Save & Lock
    final saveBtn = find.widgetWithText(ElevatedButton, 'Save & Lock');
    expect(saveBtn, findsOneWidget);
    await tester.tap(saveBtn);
    await tester.pump();
    expect(find.textContaining('Client lead stored & verified'), findsOneWidget);
    await tester.pumpAndSettle();

    // Verify modal dismissed and new client is present
    expect(find.text('Register New Buyer Lead'), findsNothing);
    expect(find.text('Dr. Alejandro Ramos'), findsOneWidget);
  });

  testWidgets('ClientsScreen search and stage filtering with added lead', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ClientsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Add a client first
    final addBtn = find.text('+ Add Client');
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Dr. Alejandro Ramos');
    await tester.enterText(textFields.at(1), '+63 917 111 2233');
    await tester.enterText(textFields.at(2), 'Phase 2 Inquiry');
    await tester.pumpAndSettle();

    final saveBtn = find.widgetWithText(ElevatedButton, 'Save & Lock');
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();

    // Search query matches
    await tester.enterText(find.byType(TextField), 'Alejandro');
    await tester.pumpAndSettle();
    expect(find.text('Dr. Alejandro Ramos'), findsOneWidget);

    // Search query does not match
    await tester.enterText(find.byType(TextField), 'NonExistentPerson');
    await tester.pumpAndSettle();
    expect(find.text('Dr. Alejandro Ramos'), findsNothing);
    expect(find.text('No matching clients found'), findsOneWidget);

    // Clear search
    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();
    expect(find.text('Dr. Alejandro Ramos'), findsOneWidget);
  });

  testWidgets('ClientsScreen tapping folder button opens detail sheet',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ClientsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Add a client first
    final addBtn = find.text('+ Add Client');
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);
    await tester.enterText(textFields.at(0), 'Dr. Alejandro Ramos');
    await tester.enterText(textFields.at(1), '+63 917 111 2233');
    await tester.enterText(textFields.at(2), 'Phase 2 Inquiry');
    await tester.pumpAndSettle();

    final saveBtn = find.widgetWithText(ElevatedButton, 'Save & Lock');
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();

    // Tap View Folder on added client
    final viewFolderBtn = find.widgetWithText(InkWell, 'View Folder');
    expect(viewFolderBtn, findsWidgets);
    await tester.tap(viewFolderBtn.first);
    await tester.pumpAndSettle();

    // Check detail sheet is visible
    expect(find.byType(ClientDetailSheet), findsOneWidget);
    expect(find.text('DIRECT CONTACT ACTIONS'), findsOneWidget);
    expect(find.text('Call Lead'), findsOneWidget);
  });
}
