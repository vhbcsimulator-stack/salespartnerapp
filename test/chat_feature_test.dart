import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/theme/app_theme.dart';
import 'package:vhbc_broker_app/features/chat/models/chat_message.dart';
import 'package:vhbc_broker_app/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:vhbc_broker_app/features/chat/presentation/widgets/chat_sheet.dart';
import 'package:vhbc_broker_app/features/chat/presentation/widgets/floating_chat_bot.dart';
import 'package:vhbc_broker_app/features/chat/services/chat_api_service.dart';

void main() {
  group('Chat Feature Tests', () {
    test('ChatMessage model creates and copies correctly', () {
      final msg = ChatMessage(
        id: '1',
        text: 'Hello Hermosa',
        sender: MessageSender.user,
        timestamp: DateTime(2026, 1, 1),
      );

      expect(msg.isUser, isTrue);
      expect(msg.isAssistant, isFalse);
      expect(msg.isError, isFalse);

      final copy = msg.copyWith(status: MessageStatus.error, errorMessage: 'Failed');
      expect(copy.isError, isTrue);
      expect(copy.errorMessage, 'Failed');
    });

    test('ChatApiService endpoint is configured to the online Render server', () {
      expect(
        ChatApiService.endpoint,
        'https://vhbc-api-server.onrender.com/api/chat',
      );
    });

    testWidgets('ChatBubble displays formatted message and sender info', (tester) async {
      final assistantMsg = ChatMessage(
        id: 'msg-1',
        text: 'Welcome to **VHBC**! We offer:\n• MVLC lots\n• ERHD community',
        sender: MessageSender.assistant,
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: ChatBubble(message: assistantMsg),
          ),
        ),
      );

      expect(find.text('Hermosa AI'), findsOneWidget);
      expect(find.text('VHBC SUPPORT'), findsOneWidget);
      expect(find.text('Copy'), findsOneWidget);
    });

    testWidgets('FloatingChatBot renders over child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const FloatingChatBot(
            child: Scaffold(
              body: Center(child: Text('Main Content')),
            ),
          ),
        ),
      );

      expect(find.text('Main Content'), findsOneWidget);
      expect(find.text('Ask Hermosa'), findsOneWidget);
      expect(find.byIcon(Icons.smart_toy_rounded), findsOneWidget);
    });

    testWidgets('HermosaChatSheet renders welcome message and quick prompts', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: HermosaChatSheet(),
          ),
        ),
      );

      // Verify header and assistant name
      expect(find.text('Hermosa AI'), findsAtLeastNWidgets(1));
      expect(find.text('ONLINE'), findsOneWidget);

      // Verify quick prompt suggestion chips
      expect(find.text('What are the amenities of MVLC?'), findsOneWidget);
      expect(find.text('Tell me about ERHD farm-resort lots'), findsOneWidget);

      // Verify text field
      expect(find.byType(TextField), findsOneWidget);
    });

    test('ChatApiService extractResponseText handles multiple formats', () {
      // 1. Gemini standard format
      final geminiJson = {
        'candidates': [
          {
            'content': {
              'parts': [
                {'text': 'Hello from Gemini!'}
              ]
            }
          }
        ]
      };
      expect(ChatApiService.extractResponseText(geminiJson), 'Hello from Gemini!');

      // 2. Custom reply format
      expect(ChatApiService.extractResponseText({'reply': 'Hello via reply'}), 'Hello via reply');
      expect(ChatApiService.extractResponseText({'message': 'Hello via message'}), 'Hello via message');
      expect(ChatApiService.extractResponseText({'response': 'Hello via response'}), 'Hello via response');
      expect(ChatApiService.extractResponseText('Plain text response'), 'Plain text response');
    });
  });
}
