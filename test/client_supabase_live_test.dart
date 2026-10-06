import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/clients/models/client_model.dart';
import 'package:vhbc_broker_app/features/clients/presentation/widgets/add_client_modal.dart';

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  test('Test SupabaseService.addClient, fetchClients, updateClientStage, deleteClient', () async {
    final testBroker = 'Juan Dela Cruz';
    final clientData = ClientModel(
      id: '',
      name: 'Integration Test Buyer',
      phone: '+63 917 555 1234',
      stage: ClientStage.hot,
      projectCode: 'MVLC',
      unitDescription: 'MVLC Development Unit',
      tcpFormatted: 'Price Upon Request',
      statusNote: 'Initial consultation complete',
      tagNote: 'Site Tripping',
      lastActivityText: 'Created just now',
      createdAt: DateTime.now(),
      brokerName: testBroker,
      notes: 'Test client notes',
    );

    // 1. Add client
    final inserted = await SupabaseService.addClient(
      clientData,
      brokerName: testBroker,
    );
    expect(inserted.id, isNotEmpty);
    expect(inserted.name, 'Integration Test Buyer');
    expect(inserted.brokerName, testBroker);

    // 2. Fetch clients
    final fetched = await SupabaseService.fetchClients(
      brokerName: testBroker,
      forceRefresh: true,
    );
    expect(fetched.any((c) => c.id == inserted.id), isTrue);

    // 3. Update stage
    await SupabaseService.updateClientStage(inserted.id, ClientStage.reserved);
    final fetchedAfterUpdate = await SupabaseService.fetchClients(
      brokerName: testBroker,
      forceRefresh: true,
    );
    final updatedClient = fetchedAfterUpdate.firstWhere((c) => c.id == inserted.id);
    expect(updatedClient.stage, ClientStage.reserved);

    // 4. Delete client
    await SupabaseService.deleteClient(inserted.id);
    final fetchedAfterDelete = await SupabaseService.fetchClients(
      brokerName: testBroker,
      forceRefresh: true,
    );
    expect(fetchedAfterDelete.any((c) => c.id == inserted.id), isFalse);
  });

  test('AddClientModal: Only active developments that are not sold out and not soon to rise are eligible', () {
    expect(AddClientModal.isProjectEligibleForClient('MVLC'), isTrue);
    expect(AddClientModal.isProjectEligibleForClient('ERHD'), isTrue);
    expect(AddClientModal.isProjectEligibleForClient('MSCC'), isTrue);

    // Sold out: EBLF must be false
    expect(AddClientModal.isProjectEligibleForClient('EBLF'), isFalse);
    expect(AddClientModal.isProjectEligibleForClient('Eastwest Breeze Leisure Farm'), isFalse);

    // Soon to rise: GLS must be false
    expect(AddClientModal.isProjectEligibleForClient('GLS'), isFalse);
    expect(AddClientModal.isProjectEligibleForClient('Green Landscape Sanctuary'), isFalse);
  });
}
