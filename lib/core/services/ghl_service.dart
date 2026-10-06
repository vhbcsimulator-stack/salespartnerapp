import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/ghl_config.dart';
import '../../features/clients/models/client_model.dart';

class GhlService {
  GhlService._();

  /// Sends a new client lead to GoHighLevel via Inbound Webhook.
  /// Returns `true` if successfully sent, `false` otherwise.
  static Future<bool> syncClientLead(ClientModel client) async {
    final urlString = GhlConfig.webhookUrl.trim();
    if (urlString.isEmpty) {
      debugPrint('[GHL Service] Webhook URL not configured. Skipping GHL lead sync.');
      return false;
    }

    try {
      final uri = Uri.parse(urlString);
      
      // Parse first and last name if possible
      final parts = client.name.trim().split(RegExp(r'\s+'));
      final firstName = parts.isNotEmpty ? parts.first : client.name;
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

      final payload = {
        'name': client.name,
        'first_name': firstName,
        'last_name': lastName,
        'phone': client.phone,
        'email': client.email ?? '',
        'project': client.projectCode,
        'stage': client.stage.name,
        'status_note': client.statusNote,
        'unit_description': client.unitDescription,
        'tcp': client.tcpFormatted,
        'vip': client.isVip,
        'source': 'BHRI Sales Partner App',
        'tracking_id': GhlConfig.trackingId,
        'created_at': client.createdAt.toIso8601String(),
        'tags': [
          'BHRI Sales Partner App',
          client.projectCode,
          client.stage.name.toUpperCase(),
          if (client.isVip) 'VIP Client',
        ],
      };

      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('[GHL Service] Lead synced successfully to GoHighLevel for: ${client.name}');
        return true;
      } else {
        debugPrint(
          '[GHL Service] Webhook responded with status: ${response.statusCode}, body: ${response.body}',
        );
        return false;
      }
    } catch (e, stack) {
      debugPrint('[GHL Service] Error syncing lead to GoHighLevel: $e\n$stack');
      return false;
    }
  }
}
