enum MessageSender {
  user,
  assistant,
}

enum MessageStatus {
  sending,
  sent,
  error,
}

/// Represents a single message in the Hermosa chat conversation.
class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final MessageStatus status;
  final String? errorMessage;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.errorMessage,
  });

  bool get isUser => sender == MessageSender.user;
  bool get isAssistant => sender == MessageSender.assistant;
  bool get isError => status == MessageStatus.error;
  bool get isSending => status == MessageStatus.sending;

  ChatMessage copyWith({
    String? id,
    String? text,
    MessageSender? sender,
    DateTime? timestamp,
    MessageStatus? status,
    String? errorMessage,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
