import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'chat_sheet.dart';

/// Draggable floating chatbot head with pulse glow animation and edge snapping.
class FloatingChatBot extends StatefulWidget {
  final Widget child;

  const FloatingChatBot({
    super.key,
    required this.child,
  });

  /// Opens the Hermosa Chat Sheet from any context in the application.
  static Future<void> openChat(BuildContext context) {
    return HermosaChatSheet.show(context);
  }

  @override
  State<FloatingChatBot> createState() => _FloatingChatBotState();
}

class _FloatingChatBotState extends State<FloatingChatBot>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Coordinates
  Offset? _position;
  bool _isDragging = false;
  bool _showLabel = true;

  static const double _buttonSize = 58.0;
  static const double _edgeMargin = 16.0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _snapToNearestEdge(Size screenSize, EdgeInsets safeArea) {
    if (_position == null) return;

    final currentX = _position!.dx;
    final currentY = _position!.dy;

    final leftBoundary = _edgeMargin;
    final rightBoundary = screenSize.width - _buttonSize - _edgeMargin;

    final targetX = (currentX < screenSize.width / 2) ? leftBoundary : rightBoundary;

    // Clamp Y to safe screen region (above bottom nav bar ~ 85px)
    final double minY = safeArea.top + 20.0;
    final double maxY = screenSize.height - safeArea.bottom - _buttonSize - 85.0;
    final double targetY = currentY.clamp(minY, max(minY, maxY)).toDouble();

    setState(() {
      _position = Offset(targetX, targetY);
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final safeArea = mediaQuery.padding;

    // Initialize default position on bottom-right, well above the bottom navigation bar
    _position ??= Offset(
      screenSize.width - _buttonSize - _edgeMargin,
      screenSize.height - safeArea.bottom - _buttonSize - 96.0,
    );

    return Stack(
      children: [
        widget.child,
        Positioned(
          left: _position!.dx,
          top: _position!.dy,
          child: GestureDetector(
            onPanStart: (_) {
              setState(() {
                _isDragging = true;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _position = Offset(
                  _position!.dx + details.delta.dx,
                  _position!.dy + details.delta.dy,
                );
              });
            },
            onPanEnd: (_) {
              _snapToNearestEdge(screenSize, safeArea);
            },
            onTap: () => FloatingChatBot.openChat(context),
            child: _buildFloatingButton(screenSize),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButton(Size screenSize) {
    final isNearRight = (_position?.dx ?? 0) > screenSize.width / 2;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final glowScale = 1.0 + (_pulseAnimation.value * 0.12);
        final glowOpacity = (0.35 - (_pulseAnimation.value * 0.20)).clamp(0.0, 1.0);

        return Material(
          type: MaterialType.transparency,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isNearRight && _showLabel && !_isDragging) ...[
                _buildLabelPill(),
                const SizedBox(width: 8),
              ],
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Pulse Glow Ring
                  Transform.scale(
                    scale: glowScale,
                    child: Container(
                      width: _buttonSize + 8,
                      height: _buttonSize + 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0F3E2E).withValues(alpha: glowOpacity),
                      ),
                    ),
                  ),
                  // Main Circular Button
                  Container(
                    width: _buttonSize,
                    height: _buttonSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00271B),
                          Color(0xFF0F3E2E),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFED48A),
                        width: 1.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00271B).withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.smart_toy_rounded,
                        color: Color(0xFFFED48A),
                        size: 26,
                      ),
                    ),
                  ),
                  // Green Online Dot
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (!isNearRight && _showLabel && !_isDragging) ...[
                const SizedBox(width: 8),
                _buildLabelPill(),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabelPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 13,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 5),
          Text(
            'Ask Hermosa',
            style: AppTextStyles.labelSm.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                _showLabel = false;
              });
            },
            child: Icon(
              Icons.close,
              size: 13,
              color: AppColors.outline.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
