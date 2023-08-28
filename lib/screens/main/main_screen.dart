import 'package:flutter/material.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/screens/dashboard/profile_screen.dart';
import '/utils/logger.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuProvider.dart';
import '../../responsive.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/settings_screen.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.tab});
  final String? tab;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authProvider = sl.get<AuthProvider>();
  final menuProvider = sl.get<MenuProvider>();
  @override
  void initState() {
    super.initState();
    menuProvider.setSideMenu('Dashboard');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.tab != null) {
        infoLog('_MainScreenState ${widget.tab}', 'tab');
        String menu = 'Dashboard';
        switch (widget.tab!.toLowerCase()) {
          case 'settings':
            menuProvider.setSideMenu('Settings');
        }
        await Future.delayed(
            const Duration(seconds: 5), () => menuProvider.setSideMenu(menu));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuProvider>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Consumer<MenuProvider>(
                builder: (context, menuProvider, child) {
                  return Builder(builder: (context) {
                    switch (menuProvider.sideMenu) {
                      case 'Dashboard':
                        return const SettingsScreen();
                      case 'Transaction':
                        return const DashboardScreen();
                      case 'Task':
                        return const DashboardScreen();
                      case 'Documents':
                        return const DashboardScreen();
                      case 'Store':
                        return const DashboardScreen();
                      case 'Notification':
                        return const DashboardScreen();
                      case 'Profile':
                        return const ProfileScreen();
                      case 'Settings':
                        return const SettingsScreen();
                      default:
                        return const DashboardScreen();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
