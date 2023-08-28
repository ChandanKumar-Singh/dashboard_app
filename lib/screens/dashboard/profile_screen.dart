import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/screens/dashboard/components/default_caontainer.dart';
import 'package:my_dashboard/screens/dashboard/components/edit_profile.dart';
import 'package:my_dashboard/utils/dialogs.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import '../../responsive.dart';

import 'components/profile/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();

  void _onRefresh() async {
    authProvider.getUserInfo();
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  //skills
  List<String> skills = [
    'Dart',
    'Flutter',
    'Version Control',
    'Firebase',
    'In-App Messaging',
    'Messaging',
    'Team Work',
    'Client Handling'
  ];

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
                const ProfileHeader(),
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
                                    _buildProfileCard(context, theme),
                                    const SizedBox(height: defaultPadding),
                                    _buildSkillCard(context, theme),
                                    const SizedBox(height: defaultPadding),
                                    _buildEmploymentDetailsCard(context, theme),
                                    if (Responsive.isMobile(context))
                                      const SizedBox(height: defaultPadding),
                                    if (Responsive.isMobile(context))
                                      const EditProfile(),
                                  ],
                                ),
                              ),
                              if (!Responsive.isMobile(context))
                                const SizedBox(width: defaultPadding),
                              // On Mobile means if the screen is less than 850 we dont want to show it
                              if (!Responsive.isMobile(context))
                                const Expanded(
                                  flex: 2,
                                  child: EditProfile(),
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

  Widget _buildEmploymentDetailsCard(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        w: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleLargeText('Employment History', context),
            height20(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 10, color: theme.splashColor),
                    width10(),
                    bodyLargeText('Flutter Developer', context),
                    width10(),
                    capText('at Cubic Quest Technologies (Lukhnow)', context),
                  ],
                ),
                height10(),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 10, color: theme.splashColor),
                    width10(),
                    bodyLargeText('Flutter Developer', context),
                    width10(),
                    capText(
                        'in 2023 at Touchwood Technologies (Mohali)', context),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildSkillCard(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        w: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleLargeText('Skill', context),
            height10(),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                ...skills.map(
                  (skill) => ChoiceChip(
                      label: capText(skill, context), selected: false),
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildProfileCard(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            const SizedBox(
                // height: 400,
                width: double.maxFinite),
            Container(
              height: 120,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  gradient: LinearGradient(colors: [
                    Color(0xEDEED562),
                    Color(0xEDECD87E),
                    Color(0xD5F1AA9B),
                    Color(0xD5F19986),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => showImageDialog(
                      context,
                      'https://assets.justinmind.com/wp-content/webp-express/webp-images/uploads/2020/02/SAp-fiori-ui-kit-dashboard-design.png.webp',
                      fromNet: true,
                      showCancel: true,
                      showCircular: true,
                      fit: BoxFit.cover,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: theme.canvasColor,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://assets.justinmind.com/wp-content/webp-express/webp-images/uploads/2020/02/SAp-fiori-ui-kit-dashboard-design.png.webp'))),
                      height: 90,
                      width: 90,
                    ),
                  ),
                  const SizedBox(height: 20),
                  titleLargeText('Chandan Kumar Singh', context),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_sharp, size: 15),
                      width5(),
                      capText('Mohali, Chnadigarh', context),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      const Icon(Icons.approval, size: 15),
                      width5(),
                      capText('@kchandankusingh', context),
                      width10(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          capText(
                              '🧑‍💻  Flutter Developer at Mohali', context),
                        ],
                      ),
                      width10(),
                      capText('Full-Time', context,
                          color: theme.textTheme.bodyMedium?.color!
                              .withOpacity(0.5)),
                    ],
                  ),
                  height10(),
                  Wrap(
                    children: [
                      OutlinedButton(
                          onPressed: () {}, child: capText('Message', context)),
                      width10(),
                      FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.share_up, size: 15),
                          label: capText('Share Profile', context,
                              color: Colors.white))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
