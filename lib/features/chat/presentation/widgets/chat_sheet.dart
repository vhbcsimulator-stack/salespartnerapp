import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/chat_message.dart';
import '../../services/chat_api_service.dart';
import 'chat_bubble.dart';
import 'typing_indicator.dart';

/// Interactive modal sheet providing the Hermosa AI chat interface for brokers.
class HermosaChatSheet extends StatefulWidget {
  const HermosaChatSheet({super.key});

  /// Opens the Hermosa Chat Sheet modally.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const HermosaChatSheet(),
    );
  }

  @override
  State<HermosaChatSheet> createState() => _HermosaChatSheetState();
}

class _HermosaChatSheetState extends State<HermosaChatSheet> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  static const List<String> _quickPrompts = [
    'What are the amenities of MVLC?',
    'Tell me about ERHD farm-resort lots',
    'What are the unit types & dues in MSCC?',
    'What are the requirements to reserve a lot?',
    'What are the turnover timelines for Westgate & Eastgate?',
  ];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    _messages.add(
      ChatMessage(
        id: 'initial-welcome',
        text: 'Hello! I am **Hermosa**, your VHBC AI assistant and Broker Support Desk specialist.\n\n'
            'My knowledge base is equipped with the official developer guides for:\n'
            '• **MVLC** (Mountain View Leisure Community)\n'
            '• **ERHD** (EastWest Resort Hub Development)\n'
            '• **MSCC** (Mountain Suites and Country Club)\n\n'
            'Ask me anything about lot cuts, unit inclusions, amenities, payment terms, or turnover timelines!',
        sender: MessageSender.assistant,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSendMessage([String? overrideText]) async {
    final text = (overrideText ?? _inputController.text).trim();
    if (text.isEmpty || _isLoading) return;

    if (overrideText == null) {
      _inputController.clear();
    }

    final userMessage = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final responseText = await ChatApiService.sendMessage(
        prompt: text,
        history: _messages,
      );

      if (!mounted) return;

      final botMessage = ChatMessage(
        id: 'bot-${DateTime.now().millisecondsSinceEpoch}',
        text: responseText,
        sender: MessageSender.assistant,
        timestamp: DateTime.now(),
        status: MessageStatus.sent,
      );

      setState(() {
        _messages.add(botMessage);
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      final errStr = e.toString();
      final String userFriendlyText;
      if (errStr.contains('warming up') || errStr.contains('timed out')) {
        userFriendlyText =
            'The VHBC server is currently waking up from sleep mode (Render free tier). Please tap **Retry** below to connect.';
      } else if (errStr.contains('Failed host lookup') ||
          errStr.contains('SocketException') ||
          errStr.contains('ClientException')) {
        userFriendlyText =
            'Unable to reach VHBC server. Please verify your internet connection and tap **Retry**.';
      } else {
        userFriendlyText =
            'Server notice: ${errStr.replaceFirst('Exception: ', '')}';
      }

      final errorMessage = ChatMessage(
        id: 'err-${DateTime.now().millisecondsSinceEpoch}',
        text: userFriendlyText,
        sender: MessageSender.assistant,
        timestamp: DateTime.now(),
        status: MessageStatus.error,
        errorMessage: errStr,
      );


      setState(() {
        _messages.add(errorMessage);
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _retryLastMessage() {
    final lastUserMsgIndex = _messages.lastIndexWhere((m) => m.isUser);
    if (lastUserMsgIndex != -1) {
      final text = _messages[lastUserMsgIndex].text;
      // Remove any trailing error message
      if (_messages.isNotEmpty && _messages.last.isError) {
        setState(() {
          _messages.removeLast();
        });
      }
      _handleSendMessage(text);
    }
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Conversation?'),
        content: const Text('This will clear the current chat history with Hermosa.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _messages.clear();
                _initializeChat();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.88,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Scaffold(
          backgroundColor: AppColors.surface,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              _buildHeader(),
              const Divider(height: 1, color: AppColors.surfaceContainerHigh),
              _buildQuickPromptsBar(),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF00271B), Color(0xFF0F3E2E)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.smart_toy_rounded,
                                color: Color(0xFFFED48A),
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const TypingIndicator(),
                          ],
                        ),
                      );
                    }

                    final msg = _messages[index];
                    return ChatBubble(
                      message: msg,
                      onRetry: msg.isError ? _retryLastMessage : null,
                    );
                  },
                ),
              ),
              _buildInputArea(bottomInset),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00271B), Color(0xFF0F3E2E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00271B).withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.smart_toy_rounded,
                        color: Color(0xFFFED48A),
                        size: 22,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Name and status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hermosa AI',
                          style: AppTextStyles.titleMd.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F6F1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'ONLINE',
                            style: AppTextStyles.labelSm.copyWith(
                              color: const Color(0xFF1E6F5C),
                              fontWeight: FontWeight.w800,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'VHBC Broker Support Desk • Online Assistant',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Clear action
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 20),
                tooltip: 'Reset Conversation',
                color: AppColors.outline,
                onPressed: _clearChat,
              ),
              // Close action
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 22),
                tooltip: 'Close',
                color: AppColors.onSurface,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPromptsBar() {
    return Container(
      height: 42,
      color: AppColors.surfaceContainerLowest,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        itemCount: _quickPrompts.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final prompt = _quickPrompts[index];
          return ActionChip(
            label: Text(
              prompt,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.primaryContainer,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
            backgroundColor: AppColors.surfaceContainerLow,
            side: BorderSide(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
              width: 1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: _isLoading ? null : () => _handleSendMessage(prompt),
          );
        },
      ),
    );
  }

  Widget _buildInputArea(double bottomInset) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10 + bottomInset),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _handleSendMessage(),
                        maxLines: null,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontSize: 13.5,
                          color: AppColors.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask Hermosa about lots, terms, guidelines...',
                          hintStyle: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.outline,
                            fontSize: 12.5,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isLoading
                      ? [Colors.grey.shade400, Colors.grey.shade500]
                      : const [Color(0xFF00271B), Color(0xFF0F3E2E)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00271B).withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _isLoading ? null : () => _handleSendMessage(),
                icon: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Color(0xFFFED48A),
                  size: 20,
                ),
                tooltip: 'Send Message',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
