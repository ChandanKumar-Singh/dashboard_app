import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_dashboard/screens/dashboard/terms_and_conditions.dart';
import '../../widgets/rich_text_editor.dart';
import '../dashboard/about_us_page.dart';
import '../dashboard/list_notifications.dart';
import '../dashboard/sendNotificationPage.dart';
import '../dashboard/store_approval_screen.dart';
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
/*    menuProvider.setSideMenu('Dashboard');
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
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        return WillPopScope(
          onWillPop: () async => onWillPOP(menuProvider),
          child: Scaffold(
            key: context.read<MenuProvider>().scaffoldKey,
            drawer: const SideMenu(),
            body: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: 300), // and it takes 1/6 part of the screen
                      child: const SideMenu(),
                    ),
                  if (Responsive.isDesktop(context))
                    const SizedBox(
                        height: double.maxFinite,
                        width: 1,
                        child: VerticalDivider(
                          thickness: 0.3,
                        )),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: Builder(
                      builder: (context) {
                        Widget child = getScreen(menuProvider);
                        infoLog(child.toString());
                        return child;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPOP(MenuProvider menuProvider) async {
    bool willBack = false;
    warningLog('OnWillPOP side menu is ${menuProvider.sideMenu}');
    if (Platform.isAndroid || Platform.isIOS) {
      if (menuProvider.sideMenu != 'Dashboard') {
        menuProvider.setSideMenu('Dashboard');
        setState(() {});
        willBack = false;
      } else {
        willBack = false;
      }
    }
    return willBack;
  }

  Widget getScreen(MenuProvider menuProvider) {
    switch (menuProvider.sideMenu) {
      case 'Dashboard':
        return const StoreApprovalScreen();
      case 'Transaction':
        return const DashboardScreen();
      case 'Task':
        return const DashboardScreen();
      case 'Documents':
        return const DashboardScreen();
      case 'Store':
        return const DashboardScreen();
      case 'Store Approval':
        return const StoreApprovalScreen();
      case 'Send Notifications':
        return const SendNotificationPage();
      case 'List Notifications':
        return const NotificationsListScreen();
      case 'Profile':
        return const ProfileScreen();
      case 'Web and App Settings':
        return const SettingsScreen();
      case 'About Us':
        return const AboutUsPage();
      case 'Terms And Conditions':
        return const TermsAndConditionsPage();
      default:
        return const DashboardScreen();
    }
  }
}
