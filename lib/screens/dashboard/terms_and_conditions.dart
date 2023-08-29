import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/rich_text_editor.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/screens/dashboard/components/default_caontainer.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';
import '../../responsive.dart';

import 'components/profile/profile_header.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const CommonHeader(),
                const SizedBox(height: defaultPadding),
                Container(
                  constraints: const BoxConstraints(maxHeight: 450,minHeight: 300),
                  child: _buildEditorSection(context, theme),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditorSection(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.all(paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bodyLargeText('Edit Terms and Conditions Content:', context),
            height10(),
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: HtmlEditorWidget())),
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
                    child: bodyLargeText('Save', context, color: Colors.white)),
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
            context,
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
            context,
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
                  child: capText('Update', context, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
