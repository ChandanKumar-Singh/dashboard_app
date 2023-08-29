import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import '/utils/picture_utils.dart';
import '../../widgets/my_load_more_delegate.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';

import 'components/profile/profile_header.dart';

class NotificationsListScreen extends StatefulWidget {
  const NotificationsListScreen({super.key});

  @override
  State<NotificationsListScreen> createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();
  int userCount = 5;
  String selectedChip = 'Customers';
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      buildChip(context, 'Customers', Icons.people, () {}),
                      buildChip(context, 'Delivery Boys', Icons.people, () {}),
                      buildChip(context, 'Stores', Icons.people, () {})
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: LoadMore(
                    isFinish: userCount >= 20,
                    onLoadMore: _loadMore,
                    whenEmptyLoad: true,
                    delegate: const MyLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          height50(),
                          assetLottie('no_notifications.json'),
                          height20(),
                          bodyLargeText('There is not any notification yet.', context),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChip(
      BuildContext context, String s, IconData icon, VoidCallback onTap) {
    bool selected = selectedChip == s;
    Color? color = selected ? getTheme.colorScheme.primary : Colors.grey;
    return GestureDetector(
      onTap: () {
        onTap();
        setState(() {
          selectedChip = s;
        });
      },
      child: Chip(
        side: BorderSide(color: color ?? Colors.grey),
        label: bodyMedText(s, context),
        avatar: Icon(icon, color: color),
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 10000));
    if (mounted) {
      setState(() {
        userCount += 5;
      });
    }
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      userCount = 5;
    });
  }
}
