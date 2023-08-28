import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_dashboard/constants.dart';
import 'package:my_dashboard/constants/assets_constant.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/additional/user_model.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/route_management/route_path.dart';
import 'package:my_dashboard/screens/auth/login_screen.dart';
import 'package:my_dashboard/utils/picture_utils.dart';
import 'package:my_dashboard/utils/sizedbox_utils.dart';
import 'package:my_dashboard/utils/text.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuProvider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        return Consumer<AuthProvider>(
          builder: (context, _authProvider, child) {
            // print(provider.currentUser.toJson());
            final authProvider = sl.get<AuthProvider>();
            return Drawer(
              backgroundColor:
                  Theme.of(context).brightness.name == Brightness.dark.name
                      ? bgColor
                      : null,
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        buildCachedNetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVLpYjzbcJkOfAsLdoC4HVA--cVGhgijlUCaHRyt0ACkYn0qMs6rgc2nrv9vYGfCE22k&usqp=CAU',
                            shape: BoxShape.circle),
                        const SizedBox(height: 10),
                        Text('authProvider.user.fullname' ?? '',
                            style: Theme.of(context).textTheme.titleSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [

                        DrawerListTile(
                          title: "Dashboard",
                          svgSrc: "assets/icons/menu_dashbord.svg",
                          press: () {
                            menuProvider.setSideMenu('Dashboard');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Transaction",
                          svgSrc: "assets/icons/menu_tran.svg",
                          press: () {
                            menuProvider.setSideMenu('Transaction');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Orders",
                          svgSrc: "assets/icons/menu_task.svg",
                          press: () {
                            menuProvider.setSideMenu('Task');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Products",
                          svgSrc: "assets/icons/menu_doc.svg",
                          press: () {
                            menuProvider.setSideMenu('Documents');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Store",
                          svgSrc: "assets/icons/menu_store.svg",
                          press: () {
                            menuProvider.setSideMenu('Store');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Locations",
                          svgSrc: "assets/icons/menu_notification.svg",
                          press: () {
                            menuProvider.setSideMenu('Notification');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Profile",
                          svgSrc: "assets/icons/menu_profile.svg",
                          press: () {
                            menuProvider.setSideMenu('Profile');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Settings",
                          svgSrc: "assets/icons/menu_setting.svg",
                          press: () {
                            menuProvider.setSideMenu('Settings');
                            menuProvider.controlMenu(context);
                          },
                        ),
                        DrawerListTile(
                          title: "Logout",
                          svgSrc: "assets/icons/menu_setting.svg",
                          press: () {
                            _authProvider.clearUser();
                            context.go(RoutePath.login);
                          },
                        ),
                        height10(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            capText('@Copyright 2023', context),
                          ],
                        ),
                        height10(),
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: darkMode ? Colors.white54 : Colors.black54,
        height: 16,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
