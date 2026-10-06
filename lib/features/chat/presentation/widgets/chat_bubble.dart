import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/chat_message.dart';

/// Bubble widget rendering individual chat messages with formatted text and actions.
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;

  const ChatBubble({
    super.key,
    required this.message,
    this.onRetry,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: message.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.primaryFixed, size: 18),
            SizedBox(width: 8),
            Text('Copied response to clipboard'),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final timeStr = DateFormat('hh:mm a').format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.primaryContainer
                        : (message.isError
                            ? AppColors.errorContainer.withValues(alpha: 0.3)
                            : AppColors.surfaceContainerLowest),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isUser
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                      bottomRight: isUser
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                    ),
                    border: Border.all(
                      color: isUser
                          ? Colors.transparent
                          : (message.isError
                              ? AppColors.error.withValues(alpha: 0.4)
                              : AppColors.outlineVariant.withValues(alpha: 0.3)),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser && !message.isError)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hermosa AI',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'VHBC SUPPORT',
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: AppColors.onSecondaryContainer,
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      _buildFormattedText(context, isUser),
                      if (!isUser && !message.isError) ...[
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => _copyToClipboard(context),
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.copy_rounded,
                                      size: 13,
                                      color: AppColors.outline,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Copy',
                                      style: AppTextStyles.labelSm.copyWith(
                                        fontSize: 10,
                                        color: AppColors.outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      timeStr,
                      style: AppTextStyles.bodySm.copyWith(
                        fontSize: 10,
                        color: AppColors.outline,
                      ),
                    ),
                    if (message.isError && onRetry != null) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onRetry,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.refresh_rounded,
                              size: 12,
                              color: AppColors.error,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              'Retry',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.error,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            _buildUserAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00271B),
            Color(0xFF0F3E2E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00271B).withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.smart_toy_rounded,
          color: Color(0xFFFED48A),
          size: 18,
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person_outline,
          color: AppColors.onSurfaceVariant,
          size: 17,
        ),
      ),
    );
  }

  Widget _buildFormattedText(BuildContext context, bool isUser) {
    final text = message.text;
    final defaultStyle = AppTextStyles.bodyMd.copyWith(
      color: isUser ? Colors.white : AppColors.onSurface,
      fontSize: 13.5,
      height: 1.45,
    );

    if (isUser) {
      return Text(text, style: defaultStyle);
    }

    // Split text by lines to parse markdown headers and bullets cleanly
    final lines = text.split('\n');
    final List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trim();

      if (trimmed.isEmpty) {
        if (i < lines.length - 1) {
          widgets.add(const SizedBox(height: 6));
        }
        continue;
      }

      // Check if bullet point or numbered item
      bool isBullet = trimmed.startsWith('* ') ||
          trimmed.startsWith('- ') ||
          trimmed.startsWith('• ');
      bool isNumbered = RegExp(r'^\d+[\.\)]\s').hasMatch(trimmed);

      String content = trimmed;
      String? prefix;

      if (isBullet) {
        prefix = '• ';
        content = trimmed.substring(2).trim();
      } else if (isNumbered) {
        final match = RegExp(r'^\d+[\.\)]\s*').firstMatch(trimmed);
        if (match != null) {
          prefix = match.group(0);
          content = trimmed.substring(match.end).trim();
        }
      }

      // Check if header (### or ##)
      final isHeader = trimmed.startsWith('### ') || trimmed.startsWith('## ');
      if (isHeader) {
        content = trimmed.replaceFirst(RegExp(r'^#+\s*'), '');
      }

      final spans = _parseInlineSpans(content, isUser, isHeader: isHeader);

      if (prefix != null) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prefix,
                  style: defaultStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: spans,
                      style: defaultStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: RichText(
              text: TextSpan(
                children: spans,
                style: isHeader
                    ? defaultStyle.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.5,
                        color: AppColors.primaryContainer,
                      )
                    : defaultStyle,
              ),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// Parses **bold** and *italic* tokens within a line
  List<TextSpan> _parseInlineSpans(String text, bool isUser, {bool isHeader = false}) {
    final List<TextSpan> spans = [];
    final regex = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*');
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }

      if (match.group(1) != null) {
        // Bold
        spans.add(
          TextSpan(
            text: match.group(1),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: isUser
                  ? Colors.white
                  : (isHeader ? AppColors.primary : AppColors.onSurface),
            ),
          ),
        );
      } else if (match.group(2) != null) {
        // Italic
        spans.add(
          TextSpan(
            text: match.group(2),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      }
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return spans;
  }
}
