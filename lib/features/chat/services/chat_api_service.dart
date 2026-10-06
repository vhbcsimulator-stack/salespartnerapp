import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/chat_message.dart';
import 'hermosa_knowledge_base.dart';

/// Service connecting to the online VHBC API server for Hermosa FAQ Gemini chat.
class ChatApiService {
  /// Base URL of the Gemini API server hosted on Render
  static const String baseUrl = 'https://vhbc-api-server.onrender.com';

  /// Primary chat API endpoint
  static const String endpoint = 'https://vhbc-api-server.onrender.com/api/chat';

  /// Health check endpoint
  static const String healthEndpoint = 'https://vhbc-api-server.onrender.com/api/health';

  /// Candidate endpoints tried in order if an endpoint returns a 404
  static const List<String> candidateEndpoints = [
    'https://vhbc-api-server.onrender.com/api/chat',
    'https://vhbc-api-server.onrender.com/chat',
    'https://vhbc-api-server.onrender.com/gemini',
    'https://vhbc-api-server.onrender.com',
  ];

  /// Official Knowledge Base system prompt derived from asset/mvlc.pdf, asset/erhd.pdf, and asset/mscc.pdf.
  static String get systemContext => HermosaKnowledgeBase.systemContext;

  /// Helper to extract assistant reply text from various API response shapes
  /// (standard Gemini candidates array, custom backend keys, or plain text).
  static String? extractResponseText(dynamic decoded) {
    if (decoded == null) return null;

    if (decoded is String && decoded.trim().isNotEmpty) {
      return decoded.trim();
    }

    if (decoded is Map<String, dynamic>) {
      // 1. Standard Gemini API format: candidates[0].content.parts[0].text
      final candidates = decoded['candidates'] as List<dynamic>?;
      if (candidates != null && candidates.isNotEmpty) {
        final first = candidates.first as Map<String, dynamic>;
        final content = first['content'] as Map<String, dynamic>?;
        final parts = content?['parts'] as List<dynamic>?;
        if (parts != null && parts.isNotEmpty) {
          final part = parts.first as Map<String, dynamic>;
          final text = part['text'] as String?;
          if (text != null && text.trim().isNotEmpty) {
            return text.trim();
          }
        }
      }

      // 2. Custom backend formats (reply, response, message, text, answer, output, content)
      for (final key in [
        'reply',
        'response',
        'message',
        'text',
        'answer',
        'output',
        'content',
      ]) {
        final val = decoded[key];
        if (val is String && val.trim().isNotEmpty) {
          return val.trim();
        }
        if (val is Map<String, dynamic>) {
          if (val['text'] is String && (val['text'] as String).trim().isNotEmpty) {
            return (val['text'] as String).trim();
          }
          if (val['content'] is String && (val['content'] as String).trim().isNotEmpty) {
            return (val['content'] as String).trim();
          }
        }
      }
    }

    return null;
  }

  /// Sends a user message along with conversation history to the online Gemini server.
  static Future<String> sendMessage({
    required String prompt,
    required List<ChatMessage> history,
  }) async {
    try {
      final List<Map<String, dynamic>> contents = [];

      // Filter out greeting message, errors, and the current prompt if already at the end of history
      final pastMessages = history.where((m) {
        if (m.id == 'initial-welcome') return false;
        if (m.status == MessageStatus.error) return false;
        if (m.text.trim().isEmpty) return false;
        return true;
      }).toList();

      // Ensure we don't duplicate the current prompt if it's already the last element in history
      if (pastMessages.isNotEmpty &&
          pastMessages.last.isUser &&
          pastMessages.last.text.trim() == prompt.trim()) {
        pastMessages.removeLast();
      }

      // Keep recent turns (up to 8 messages)
      final recentHistory = pastMessages.length > 8
          ? pastMessages.sublist(pastMessages.length - 8)
          : pastMessages;

      for (final msg in recentHistory) {
        contents.add({
          'role': msg.isUser ? 'user' : 'model',
          'parts': [
            {'text': msg.text},
          ],
        });
      }

      // Provide the official developer documentation files for the AI to read on the first turn
      final String userMessageText = recentHistory.isEmpty
          ? '$systemContext\n\nUser Question:\n$prompt'
          : prompt;

      contents.add({
        'role': 'user',
        'parts': [
          {'text': userMessageText},
        ],
      });

      // Construct payload with systemInstruction and contents
      final body = jsonEncode({
        'contents': contents,
        'prompt': prompt,
        'message': prompt,
        'systemInstruction': {
          'parts': [
            {'text': systemContext}
          ]
        },
      });

      // Attempt primary endpoint, with fallback to other candidates if 404 is encountered
      for (final targetUrl in candidateEndpoints) {
        try {
          final uri = Uri.parse(targetUrl);
          final response = await http
              .post(
                uri,
                headers: const {
                  'Content-Type': 'application/json',
                },
                body: body,
              )
              .timeout(
                const Duration(seconds: 60),
                onTimeout: () => throw Exception(
                  'Connection timed out. The server is warming up from sleep mode (Render free tier). Please tap Retry in a few seconds.',
                ),
              );

          if (response.statusCode >= 200 && response.statusCode < 300) {
            final dynamic decoded = jsonDecode(response.body);
            final extracted = extractResponseText(decoded);
            if (extracted != null && extracted.isNotEmpty) {
              return extracted;
            }
            throw Exception('Received empty response from AI server.');
          } else if (response.statusCode == 404) {
            // Try next candidate endpoint
            continue;
          } else if (response.statusCode == 429) {
            throw Exception(
              'The AI service is experiencing high traffic (rate limit reached). Please wait a few moments and tap Retry.',
            );
          } else {
            final dynamic decoded = jsonDecode(response.body);
            final message = decoded is Map<String, dynamic> ? decoded['message'] : null;
            throw Exception(message ?? 'Server error (${response.statusCode}). Please tap Retry.');
          }
        } catch (e) {
          if (targetUrl == candidateEndpoints.last ||
              e.toString().contains('timed out') ||
              e.toString().contains('rate limit')) {
            rethrow;
          }
          debugPrint('Error contacting $targetUrl: $e');
        }
      }

      throw Exception('Unable to reach AI server. Please tap Retry.');
    } catch (e) {
      debugPrint('Notice: VHBC Online Chat API exception: $e');
      rethrow;
    }
  }
}
