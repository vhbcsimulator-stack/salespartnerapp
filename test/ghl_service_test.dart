import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/config/ghl_config.dart';
import 'package:vhbc_broker_app/core/services/ghl_service.dart';
import 'package:vhbc_broker_app/features/clients/models/client_model.dart';

void main() {
  test('GhlService.syncClientLead returns false gracefully when webhookUrl is empty', () async {
    GhlConfig.webhookUrl = '';

    final client = ClientModel(
      id: 'test-client',
      name: 'John Doe',
      subtitle: 'Buyer Lead',
      phone: '+63 917 123 4567',
      stage: ClientStage.hot,
      isVip: false,
      projectCode: 'MVLC',
      unitDescription: 'Phase 2 Lot 10',
      tcpFormatted: '₱1.50M TCP',
      statusNote: 'Inquiry received',
      tagNote: 'Follow-up',
      lastActivityText: 'Just now',
      createdAt: DateTime.now(),
    );

    final result = await GhlService.syncClientLead(client);
    expect(result, isFalse);
  });
}
