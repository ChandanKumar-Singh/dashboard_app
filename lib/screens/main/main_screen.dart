import 'package:flutter/material.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/screens/dashboard/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/MenuProvider.dart';
import '../../responsive.dart';
import '../dashboard/dashboard_screen.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authProvider = sl.get<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuProvider>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
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
                        return DashboardScreen();
                      case 'Transaction':
                        return DashboardScreen();
                      case 'Task':
                        return DashboardScreen();
                      case 'Documents':
                        return DashboardScreen();
                      case 'Store':
                        return DashboardScreen();
                      case 'Notification':
                        return DashboardScreen();
                      case 'Profile':
                        return ProfileScreen();
                      case 'Settings':
                        return DashboardScreen();
                      default:
                        return DashboardScreen();
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
