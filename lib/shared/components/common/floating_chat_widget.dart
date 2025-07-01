import 'package:flutter/material.dart';
import '../../../core/constants/colors/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../modules/chat_ai/chat_ai_screen.dart';

class FloatingChatWidget extends StatefulWidget {
  const FloatingChatWidget({super.key});

  @override
  State<FloatingChatWidget> createState() => _FloatingChatWidgetState();
}

class _FloatingChatWidgetState extends State<FloatingChatWidget> {
  bool _isExpanded = false;
  bool _isDragging = false;
  Offset _position = const Offset(16, 100);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          _isDragging = true;
        },
        onPanUpdate: (details) {
          setState(() {
            _position = Offset(
              (_position.dx + details.delta.dx).clamp(
                0.0,
                MediaQuery.of(context).size.width - 60,
              ),
              (_position.dy + details.delta.dy).clamp(
                0.0,
                MediaQuery.of(context).size.height - 150,
              ),
            );
          });
        },
        onPanEnd: (details) {
          _isDragging = false;
        },
        onTap: () {
          if (!_isDragging) {
            if (_isExpanded) {
              _showChatDialog();
            } else {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isExpanded ? 200 : 60,
          height: _isExpanded ? 120 : 60,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _isExpanded ? _buildExpandedWidget() : _buildCollapsedWidget(),
        ),
      ),
    );
  }

  Widget _buildCollapsedWidget() {
    return const Icon(
      Icons.chat_bubble_outline,
      color: AppColors.white,
      size: 28,
    );
  }

  Widget _buildExpandedWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.smart_toy, color: AppColors.white, size: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'AI Assistant',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Nhấn để mở chat',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              fontSize: 10,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Mở',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChatDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(child: const ChatAIScreen()),
    );
  }
}
