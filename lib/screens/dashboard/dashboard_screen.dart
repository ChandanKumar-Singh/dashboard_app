import 'package:flutter/material.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/header.dart';

import 'components/my_fields.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();

  void _onRefresh() async {
    authProvider.getUserInfo();
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Header(),
                const SizedBox(height: defaultPadding),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: _refreshController,
                    header: const MaterialClassicHeader(),
                    onRefresh: _onRefresh,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    const MyFiles(),
                                    const SizedBox(height: defaultPadding),
                                    const RecentFiles(),
                                    if (Responsive.isMobile(context))
                                      const SizedBox(height: defaultPadding),
                                    if (Responsive.isMobile(context))
                                      const StarageDetails(),
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(width: defaultPadding),
                              // On Mobile means if the screen is less than 850 we dont want to show it
                              if (!Responsive.isMobile(context))
                                const Expanded(
                                  flex: 2,
                                  child: StarageDetails(),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
