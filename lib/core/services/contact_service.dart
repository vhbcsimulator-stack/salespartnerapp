import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/broker_contact_sheet.dart';

/// Centralized service for broker support and reservation desk contacts.
class ContactService {
  ContactService._();

  /// Primary desk contact number: 09171897112
  static const String salesDeskNumber = '09171897112';

  /// Initiates contact with the sales desk by launching the dialer and opening the phone contacts sheet.
  static Future<void> callSalesDesk({
    required BuildContext context,
    String title = 'Broker Support & Reservations',
    String? subtitle,
    String? lotInfo,
    String? feedbackMessage,
  }) async {
    // 1. Attempt native dialer without blocking sheet display
    final Uri telUri = Uri.parse('tel:$salesDeskNumber');
    launchUrl(telUri, mode: LaunchMode.externalApplication).catchError((_) => false);

    // 2. Open the phone contacts sheet so the user always has the interactive contact options
    if (context.mounted) {
      await BrokerContactSheet.show(
        context,
        title: title,
        subtitle: subtitle,
        lotInfo: lotInfo,
      );
    }
  }
}
