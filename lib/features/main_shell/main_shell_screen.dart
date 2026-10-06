import 'package:flutter/material.dart';
import '../chat/presentation/widgets/floating_chat_bot.dart';
import '../clients/presentation/clients_screen.dart';
import '../home/presentation/home_screen.dart';
import '../inventory/presentation/inventory_screen.dart';
import '../profile/presentation/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

/// Main Shell hosting the modular screens and bottom navigation.
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
        HomeScreen(onNavigateTab: _onTabSelected),
        const InventoryScreen(),
        const ClientsScreen(),
        const ProfileScreen(),
      ];

  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingChatBot(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}

