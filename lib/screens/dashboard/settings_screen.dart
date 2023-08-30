import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/screens/dashboard/components/default_caontainer.dart';
import '/screens/dashboard/components/edit_profile.dart';
import '/utils/dialogs.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import '../../responsive.dart';

import 'components/profile/profile_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();

  void _onRefresh() async {
    // authProvider.getUserInfo();
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                const CommonHeader(),
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
                                    _buildFCMSetup(context, theme),
                                    const SizedBox(height: defaultPadding),
                                    _buildAppSetup(context, theme),
                                    const SizedBox(height: defaultPadding),
                                    _buildAppService(context, theme),
                                    if (Responsive.isMobile(context))
                                      const SizedBox(height: defaultPadding),
                                    if (Responsive.isMobile(context))
                                      const _UpdateAppAssets(),
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(width: defaultPadding),
                              // On Mobile means if the screen is less than 850 we dont want to show it
                              if (!Responsive.isMobile(context))
                                const Expanded(
                                  flex: 2,
                                  child: _UpdateAppAssets(),
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

  Widget _buildAppService(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bodyLargeText('Services'),
            height10(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                SizedBox(
                  width: 300,
                  child: SwitchListTile(
                    value: true,
                    title: bodyLargeText('App Enabled'),
                    onChanged: (val) {},
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: SwitchListTile(
                    value: true,
                    title: bodyLargeText('App Enabled'),
                    onChanged: (val) {},
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: SwitchListTile(
                    value: true,
                    title: bodyLargeText('App Enabled'),
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
            height20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      primaryFocus?.unfocus();
                    },
                    child: bodyLargeText('Save', color: Colors.white)),
              ],
            ),
          ],
        ));
  }

  Widget _buildAppSetup(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bodyLargeText('App Setup'),
            height10(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'App Name'),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'App Name'),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        labelText: 'App Name'),
                  ),
                ),
              ],
            ),
            height20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      primaryFocus?.unfocus();
                    },
                    child: bodyLargeText('Save', color: Colors.white)),
              ],
            ),
          ],
        ));
  }

  Widget _buildFCMSetup(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bodyLargeText('FCM Server Setup'),
            height10(),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key), labelText: 'Web server key'),
            ),
            height10(),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.credit_card_rounded),
                  labelText: 'Sender ID'),
            ),
            height10(),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.credit_card_sharp),
                  labelText: 'Project ID'),
            ),
            height20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      primaryFocus?.unfocus();
                    },
                    child: bodyLargeText('Save', color: Colors.white)),
              ],
            ),
          ],
        ));
  }
}

class _UpdateAppAssets extends StatelessWidget {
  const _UpdateAppAssets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyLargeText(
            "App Banner",
            fontWeight: FontWeight.normal,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://assets.justinmind.com/wp-content/webp-express/webp-images/uploads/2020/02/dashboard-example-podcast-insoft.png.webp'),
                              fit: BoxFit.cover)),
                      constraints:
                          BoxConstraints(maxHeight: 200, maxWidth: 500),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton.filled(
                            onPressed: () {}, icon: const Icon(Icons.edit)))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
          bodyLargeText(
            "App Logo",
            fontWeight: FontWeight.normal,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVzg59XB74ljlpidx5dQ29O9M8J2norxRHFA&usqp=CAU'),
                              fit: BoxFit.cover)),
                      constraints:
                      BoxConstraints(maxHeight: 200, maxWidth: 500),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton.filled(
                            onPressed: () {}, icon: const Icon(Icons.edit)))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                  onPressed: () {},
                  child: capText('Update', color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
