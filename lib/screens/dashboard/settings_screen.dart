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

class Web_AppSettingsScreen extends StatefulWidget {
  const Web_AppSettingsScreen({super.key});

  @override
  State<Web_AppSettingsScreen> createState() => _Web_AppSettingsScreenState();
}

class _Web_AppSettingsScreenState extends State<Web_AppSettingsScreen> {
  final ScrollController sc = ScrollController();

  List<GlobalKey> widgetKeys = [];
  List<String> hashes = [
    'FCM Server Setup',
    'App Setup',
    'Services',
    'App Assets'
  ];

  @override
  void initState() {
    if (hashes.isNotEmpty) {
      widgetKeys =
          List<GlobalKey>.generate(hashes.length, (index) => GlobalKey());
      setState(() {});
    }
    super.initState();
  }

  void _scrollToWidget(GlobalKey key) {
    sc.position.ensureVisible(
      key.currentContext!.findRenderObject()!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    /* double offset = 0;
    final box = _globalKey.currentContext?.findRenderObject() as RenderBox;
    final boxHeight = box.size.height;
    Offset boxPosition = box.localToGlobal(Offset.zero);
    double boxY = (boxPosition.dy - boxHeight / 2);
    sc.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );*/
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
                CommonHeader(
                  secondaryWidget: (Responsive.isMobile(context))
                      ? Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<int>(
                                  offset: const Offset(0, 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  position: PopupMenuPosition.under,
                                  onSelected: (i) =>
                                      _scrollToWidget(widgetKeys[i]),
                                  itemBuilder: (ctx) => widgetKeys.map((e) {
                                        var index = widgetKeys.indexOf(e);
                                        return PopupMenuItem(
                                          value: index,
                                          child: bodyMedText(hashes[index]),
                                        );
                                      }).toList()),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                const SizedBox(height: defaultPadding),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SingleChildScrollView(
                          controller: sc,
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            children: [
                              _buildFCMSetup(context, theme, widgetKeys[0]),
                              const SizedBox(height: defaultPadding),
                              _buildAppSetup(context, theme, widgetKeys[1]),
                              const SizedBox(height: defaultPadding),
                              _buildAppService(context, theme, widgetKeys[2]),
                              const SizedBox(height: defaultPadding),
                              _UpdateAppAssets(key: widgetKeys[3]),
                            ],
                          ),
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        Expanded(
                          flex: 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...widgetKeys.map((e) {
                                  int index = widgetKeys.indexOf(e);
                                  return InkWell(
                                    child: GestureDetector(
                                      onTap: () =>
                                          _scrollToWidget(widgetKeys[index]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: bodyMedText(hashes[index]),
                                      ),
                                    ),
                                  );
                                })
                              ]),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppService(BuildContext context, ThemeData theme,
      GlobalKey<State<StatefulWidget>> key) {
    return defaultContainer(context,
        key: key,
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

  Widget _buildAppSetup(BuildContext context, ThemeData theme,
      GlobalKey<State<StatefulWidget>> key) {
    return defaultContainer(context,
        key: key,
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

  Widget _buildFCMSetup(BuildContext context, ThemeData theme,
      GlobalKey<State<StatefulWidget>> key) {
    return defaultContainer(context,
        key: key,
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
      key: key,
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
