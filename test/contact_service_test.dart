import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/contact_service.dart';

void main() {
  group('ContactService Tests', () {
    test('salesDeskNumber is configured to the required phone number', () {
      expect(ContactService.salesDeskNumber, '09171897112');
    });

    test('salesDeskNumber is an 11-digit mobile number starting with 09', () {
      expect(ContactService.salesDeskNumber.length, 11);
      expect(ContactService.salesDeskNumber.startsWith('0917'), isTrue);
    });
  });
}
