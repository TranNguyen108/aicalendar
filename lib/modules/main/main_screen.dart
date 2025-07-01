import 'package:flutter/material.dart';
import '../../shared/components/common/bottom_navigation_widget.dart';
import '../../shared/components/common/floating_chat_widget.dart';
import '../homepage/homepage_screen.dart';
import '../calendar/calendar_screen.dart';
import '../tasks/tasks_screen.dart';
import '../settings/settings_screen.dart';
import '../quick_add/quick_add_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const CalendarScreen(),
    const Placeholder(), // QuickAdd will be modal
    const TasksScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          IndexedStack(index: _currentIndex, children: _screens),

          // Floating Chat Widget
          const FloatingChatWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            // Quick Add - show modal instead of navigation
            _showQuickAddModal();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }

  void _showQuickAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickAddScreen(),
    );
  }
}
