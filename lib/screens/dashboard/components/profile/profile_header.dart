import 'package:flutter/material.dart';
import '/constants.dart';
import '/responsive.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/MenuProvider.dart';

class CommonHeader extends StatefulWidget {
  const CommonHeader({
    Key? key,
    this.secondaryWidget,
  }) : super(key: key);
  final Widget? secondaryWidget;
  @override
  State<CommonHeader> createState() => _CommonHeaderState();
}

class _CommonHeaderState extends State<CommonHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 60,
          padding: EdgeInsets.symmetric(
              vertical: Responsive.isMobile(context) ? 0 : defaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!Responsive.isDesktop(context))
                IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () =>
                        context.read<MenuProvider>().controlMenu(context)),
              if (!Responsive.isMobile(context))
                Row(
                  children: [
                    const SizedBox(width: defaultPadding),
                    Text(
                      provider.sideMenu,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              // if (!Responsive.isMobile(context))
              //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              const SizedBox(width: defaultPadding),
              // Spacer(),
              if (widget.secondaryWidget != null)
                widget.secondaryWidget!, // ProfileCard()
            ],
          ),
        );
      },
    );
  }

  Widget _buildSections(MenuProvider provider) {
    bool isDesktop = Responsive.isDesktop(context);
    if (isDesktop) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...provider.headerContent.map((e) {
            var index = provider.headerContent.indexOf(e);
            return InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                provider.setSection(index);
              }),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: provider.section == index
                      ? Theme.of(context).canvasColor
                      : Colors.transparent,
                ),
                child: Center(
                  child: capText(e.toUpperCase(), context,
                      color: provider.section == index
                          ? Theme.of(context).textTheme.titleLarge?.color
                          : Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.color!
                              .withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          })
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _SectionPopUpMenuWidget(
              sections: provider.headerContent,
              callBack: (val) {
                provider.setSection(provider.headerContent.indexOf(val));
              },
              section: provider.section),
        ],
      );
    }
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, provider, child) {
        return Expanded(child: _buildSections(provider));
      },
    );
  }

  Widget _buildSections(MenuProvider provider) {
    bool isDesktop = Responsive.isDesktop(context);
    if (isDesktop) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...provider.headerContent.map((e) {
            var index = provider.headerContent.indexOf(e);
            return InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                provider.setSection(index);
              }),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: provider.section == index
                      ? Theme.of(context).canvasColor
                      : Colors.transparent,
                ),
                child: Center(
                  child: capText(e.toUpperCase(), context,
                      color: provider.section == index
                          ? Theme.of(context).textTheme.titleLarge?.color
                          : Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.color!
                              .withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          })
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _SectionPopUpMenuWidget(
              sections: provider.headerContent,
              callBack: (val) {
                provider.setSection(provider.headerContent.indexOf(val));
              },
              section: provider.section),
        ],
      );
    }
  }
}

class _SectionPopUpMenuWidget extends StatelessWidget {
  const _SectionPopUpMenuWidget(
      {Key? key,
      required this.sections,
      required this.callBack,
      required this.section})
      : super(key: key);

  final List<String> sections;
  final int section;
  final void Function(String section) callBack;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      margin: const EdgeInsets.only(
          left: defaultPadding, right: defaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: PopupMenuButton<String>(
        initialValue: sections[section],
        offset: const Offset(100, 0),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (BuildContext context) {
          return [
            ...sections
                .map<PopupMenuItem<String>>(
                    (e) => PopupMenuItem<String>(value: e, child: Text(e)))
                .toList(),
          ];
        },
        onSelected: callBack,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(sections[section]),
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
