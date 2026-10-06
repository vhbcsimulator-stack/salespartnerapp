/// GoHighLevel (GHL) integration configuration
class GhlConfig {
  GhlConfig._();

  /// GoHighLevel Inbound Webhook URL.
  /// Paste your GHL workflow inbound webhook URL here or provide via --dart-define=GHL_WEBHOOK_URL=...
  static String webhookUrl = const String.fromEnvironment(
    'GHL_WEBHOOK_URL',
    defaultValue: '',
  );

  /// GoHighLevel External Tracking ID from your tracking script
  static const String trackingId = 'tk_a84c14fd4fc043428e82e0b419d4fcfc';
}
