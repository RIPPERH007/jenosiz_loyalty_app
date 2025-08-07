import 'package:flutter/material.dart';
import 'package:jenosize_loyalty_app/presentation/screens/points/point_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_string.dart';
import 'home/home_screen.dart';
import 'membership/membership_screen.dart';
import 'referral/referral_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MembershipScreen(),
    const ReferralScreen(),
    const PointsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            activeIcon: Icon(Icons.home_rounded),
            label: AppStrings.navHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership_rounded),
            activeIcon: Icon(Icons.card_membership_rounded),
            label: AppStrings.navMembership,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            activeIcon: Icon(Icons.people_rounded),
            label: AppStrings.navReferral,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars_rounded),
            activeIcon: Icon(Icons.stars_rounded),
            label: AppStrings.navPoints,
          ),
        ],
      ),
    );
  }
}
