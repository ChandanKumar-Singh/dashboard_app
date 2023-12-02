import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_dashboard/utils/logger.dart';
import '../../../constants/side_menu_const.dart' as smc;
import '/constants.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/utils/picture_utils.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuProvider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
/*    //navigation
    String dashboard = 'Dashboard';

    //settings
    String web_app_setting = 'Web and App Settings';
    String tax_management = 'Tax Management';
    String id_management = 'ID Management';
    String memberships_plans = 'Membership Plans';

    //team management
    String sub_admins = 'Sub-Admin';
    String roles = 'Roles';
    String sub_admin = 'Sub-Admin';
    String manage_city_adminers = 'Manage CityAdminers';

    //customer management
    String user_management = 'User Management';
    String user_data = 'User Data';
    String wallet_recharge_history = 'Wallet Recharge History';

    //categories & products
    String category_mangement = 'Category Management';
    String parent_categories = 'Parent Categories';
    String sub_categories = 'Sub Categories';

    String product_catalog = 'Product Catalog';
    String admin_products = 'Admin Products';
    String store_products = 'Store Products(request)';
    String trending_search = 'Trending Search';

    //vendor
    String stores = 'Store Management';
    String storeList = 'Store List';
    String storeEarning = 'Store Earning/Payments';
    String storeApproval = 'Store Approval';

    String payout = 'Payout';
    String payoutRequests = 'Payout Requests';
    String payoutValidation = 'Payout Validation';

    //orders
    String orders = 'Order Management';
    String re_store_orders = 'Rejected By Store';
    String all_orders = 'All Orders';
    String pend_orders = 'Pending Orders';
    String canc_orders = 'Cancelled Orders';
    String ong_orders = 'Ongoing Orders';
    String out_f_del_orders = 'Out For Delivery Orders';
    String pay_fail_orders = 'Payment Failed Orders';
    String com_orders = 'Completed Orders';
    String day_wise_orders = 'Day Wise Orders';
    String miss_orders = 'Missed Orders';

    //delivery settings
    String deliveryBoy = 'Delivery Boy';
    String deliveryBoyIncentive = 'Delivery Boy Intensive';
    String setDeliveryBoyIncentive = 'Set Delivery Boy Incentive';

    String areaMangement = 'Area Management';
    String cities = 'cities';
    String area_society = 'Area/Society';
    String bulk_upload = 'bulk_upload';

    //notifications
    String notifications = 'Notifications';
    String sendNotification = 'Send Notifications';
    String listNotification = 'List Notifications';
    String appNotice = 'App Notice';

    //analytics
    String reports = 'Reports';
    String item_requirement = 'Item Requirement(Day-Wise)';
    String item_sales_rep = 'Item Seles Report (last 30 Days)';
    String tax_reports = 'Tax Reports';

    String feedback = 'Feedback';
    String userFeedback = 'Feedback';
    String storeFeedback = 'Feedback';
    String deliveryBoyFeedback = 'Delivery Boy Feedback';

    String cancellingReasons = 'Cancelling Reasons';

    String callBackRequests = 'CallBack Requests';
    String u_callBackRequests = 'User CallBack Requests';
    String s_callBackRequests = 'Stores CallBack Requests';
    String d_callBackRequests = 'Delivery Boy CallBack Requests';

    // reward management
    String rewards = 'Rewards';
    String redeemValue = 'Redeem Value';

    //page management
    String pages = 'Pages';
    String aboutUs = 'About Us';
    String terms_condition = 'Terms And Conditions';

    String transaction = 'Transaction';

    //Categories and Products
    String category = 'Categories Management';
    String parentCategory = 'Parent Categories';
    String subCategory = 'Sub Categories';

    String products = 'Product Catalog';
    String adminProducts = 'Admin Products';
    String storeProducts = 'Store Products';

    String analytics = 'Analytics';

    String report = 'Reports';*/

    return Consumer<MenuProvider>(
      builder: (context, menuProvider, child) {
        return Consumer<AuthProvider>(
          builder: (context, _authProvider, child) {
            // print(provider.currentUser.toJson());
            final authProvider = sl.get<AuthProvider>();
            return Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              backgroundColor:
                  Theme.of(context).brightness.name == Brightness.dark.name
                      ? bgColor
                      : creamColor,
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(paddingDefault),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCachedNetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVLpYjzbcJkOfAsLdoC4HVA--cVGhgijlUCaHRyt0ACkYn0qMs6rgc2nrv9vYGfCE22k&usqp=CAU',
                            shape: BoxShape.circle),
                        const SizedBox(height: 10),
                        Text(authProvider.currentUser.fullname ?? '',
                            style: Theme.of(context).textTheme.titleSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: paddingDefault),
                      children: [
                        //navigation
                        buildSectionHeader(context, 'navigation'),
                        buildDrawerListTile(
                            smc.dashboard, 'menu_dashbord.svg', menuProvider),

                        //settings
                        buildSectionHeader(context, 'settings'),
                        buildDrawerListTile(smc.web_app_setting,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(smc.tax_management,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(smc.id_management,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(smc.memberships_plans,
                            'menu_dashbord.svg', menuProvider),

                        //team management
                        buildSectionHeader(context, 'team management'),
                        buildDrawerListTile(smc.sub_admins, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(
                              smc.roles, 'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(
                              smc.sub_admin, 'menu_dashbord.svg', menuProvider),
                        ]),
                        buildDrawerListTile(smc.manage_city_adminers,
                            'menu_dashbord.svg', menuProvider),

                        //customer management
                        buildSectionHeader(context, 'customer management'),
                        buildDrawerListTile(smc.user_management,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(
                              smc.user_data, 'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.wallet_recharge_history,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        //categories & products
                        buildSectionHeader(context, 'categories & products'),
                        buildDrawerListTile(smc.category_mangement,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(smc.parent_categories,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.sub_categories,
                              'menu_dashbord.svg', menuProvider),
                        ]),
                        buildDrawerListTile(smc.product_catalog,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(smc.admin_products,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.store_products,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.trending_search,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        //vendor
                        buildSectionHeader(context, 'vendor'),
                        buildDrawerListTile(smc.stores, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(
                              smc.storeList, 'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.storeEarning,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.storeApproval,
                              'menu_dashbord.svg', menuProvider),
                        ]),
                        buildDrawerListTile(smc.payout, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(smc.payoutRequests,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.payoutValidation,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        //orders
                        buildSectionHeader(context, 'orders'),
                        buildDrawerListTile(smc.orders, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(smc.re_store_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.all_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.pend_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.canc_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.ong_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.out_f_del_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.pay_fail_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.com_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.day_wise_orders,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.miss_orders,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        //delivery settings
                        buildSectionHeader(context, 'delivery settings'),
                        buildDrawerListTile(smc.deliveryBoy,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(smc.deliveryBoy,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.deliveryBoyIncentive,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.setDeliveryBoyIncentive,
                              'menu_dashbord.svg', menuProvider),
                        ]),
                        buildDrawerListTile(smc.areaMangement,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(
                              smc.cities, 'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.area_society,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.bulk_upload,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        //notifications
                        buildSectionHeader(context, smc.notifications),
                        buildDrawerListTile(smc.sendNotification,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(smc.listNotification,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(
                            smc.appNotice, 'menu_dashbord.svg', menuProvider),

                        //analytics
                        buildSectionHeader(context, 'analytics'),
                        buildDrawerListTile(smc.reports, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(smc.item_requirement,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.item_sales_rep,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.tax_reports,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(
                              smc.reports, 'menu_dashbord.svg', menuProvider),
                        ]),
                        buildDrawerListTile(smc.cancellingReasons,
                            'menu_dashbord.svg', menuProvider),
                        buildDrawerListTile(smc.callBackRequests,
                            'menu_dashbord.svg', menuProvider, true, [
                          buildDrawerListTile(smc.u_callBackRequests,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.s_callBackRequests,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.d_callBackRequests,
                              'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(
                              smc.reports, 'menu_dashbord.svg', menuProvider),
                        ]),

                        //page management
                        buildSectionHeader(context, 'pages management'),
                        buildDrawerListTile(smc.pages, 'menu_dashbord.svg',
                            menuProvider, true, [
                          buildDrawerListTile(
                              smc.aboutUs, 'menu_dashbord.svg', menuProvider),
                          buildDrawerListTile(smc.terms_condition,
                              'menu_dashbord.svg', menuProvider),
                        ]),

                        // DrawerListTile(
                        //   title: transaction,
                        //   svgSrc: "assets/icons/menu_tran.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(transaction);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == transaction,
                        // ),
                        // buildSectionHeader(context, 'Categories & Products'),
                        // DrawerListTile(
                        //   title: category,
                        //   svgSrc: "assets/icons/menu_task.svg",
                        //   press: () {
                        //     // menuProvider.setSideMenu(products);
                        //     // menuProvider.controlMenu(context);
                        //   },
                        //   // selected: menuProvider.sideMenu == products,
                        //   children: [
                        //     DrawerListTile(
                        //       title: parentCategory,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(parentCategory);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == parentCategory,
                        //     ),
                        //     DrawerListTile(
                        //       title: subCategory,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(subCategory);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == subCategory,
                        //     ),
                        //   ],
                        // ),
                        // DrawerListTile(
                        //   title: products,
                        //   svgSrc: "assets/icons/menu_task.svg",
                        //   press: () {
                        //     // menuProvider.setSideMenu(products);
                        //     // menuProvider.controlMenu(context);
                        //   },
                        //   // selected: menuProvider.sideMenu == products,
                        //   children: [
                        //     DrawerListTile(
                        //       title: adminProducts,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(adminProducts);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == adminProducts,
                        //     ),
                        //     DrawerListTile(
                        //       title: storeProducts,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(storeProducts);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == storeProducts,
                        //     ),
                        //   ],
                        // ),
                        // buildSectionHeader(context, 'Orders'),
                        // DrawerListTile(
                        //   title: orders,
                        //   svgSrc: "assets/icons/menu_task.svg",
                        //   press: () {
                        //     // menuProvider.setSideMenu(orders);
                        //     // menuProvider.controlMenu(context);
                        //   },
                        //   children: [
                        //     DrawerListTile(
                        //       title: re_store_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(re_store_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == re_store_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: all_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(all_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == all_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: pend_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(pend_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == pend_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: canc_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(canc_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == canc_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: ong_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(ong_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == ong_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: out_f_del_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(out_f_del_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == out_f_del_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: pay_fail_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(pay_fail_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == pay_fail_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: com_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(com_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == com_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: day_wise_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(day_wise_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == day_wise_orders,
                        //     ),
                        //     DrawerListTile(
                        //       title: miss_orders,
                        //       svgSrc: "assets/icons/menu_task.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(miss_orders);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == miss_orders,
                        //     ),
                        //   ],
                        // ),
                        // buildSectionHeader(context, 'Vendors'),
                        // DrawerListTile(
                        //   title: stores,
                        //   svgSrc: "assets/icons/menu_store.svg",
                        //   press: () {
                        //     // menuProvider.setSideMenu(stores);
                        //     // menuProvider.controlMenu(context);
                        //   },
                        //   // selected: menuProvider.sideMenu == stores,
                        //   children: [
                        //     DrawerListTile(
                        //       title: storeList,
                        //       svgSrc: "assets/icons/menu_store.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(storeList);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == storeList,
                        //     ),
                        //     DrawerListTile(
                        //       title: storeEarning,
                        //       svgSrc: "assets/icons/menu_store.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(storeEarning);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == storeEarning,
                        //     ),
                        //     DrawerListTile(
                        //       title: storeApproval,
                        //       svgSrc: "assets/icons/menu_store.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(storeApproval);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == storeApproval,
                        //     ),
                        //   ],
                        // ),
                        // DrawerListTile(
                        //   title: payout,
                        //   svgSrc: "assets/icons/menu_store.svg",
                        //   press: () {
                        //     // menuProvider.setSideMenu(stores);
                        //     // menuProvider.controlMenu(context);
                        //   },
                        //   // selected: menuProvider.sideMenu == stores,
                        //   children: [
                        //     DrawerListTile(
                        //       title: payoutRequests,
                        //       svgSrc: "assets/icons/menu_store.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(payoutRequests);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == payoutRequests,
                        //     ),
                        //     DrawerListTile(
                        //       title: payoutValidation,
                        //       svgSrc: "assets/icons/menu_store.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(payoutValidation);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == payoutValidation,
                        //     ),
                        //   ],
                        // ),
                        // buildSectionHeader(context, 'Notifications'),
                        // DrawerListTile(
                        //   title: sendNotification,
                        //   svgSrc: "assets/icons/menu_notification.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(sendNotification);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == sendNotification,
                        // ),
                        // DrawerListTile(
                        //   title: listNotification,
                        //   svgSrc: "assets/icons/menu_notification.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(listNotification);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == listNotification,
                        // ),
                        // DrawerListTile(
                        //   title: appNotice,
                        //   svgSrc: "assets/icons/menu_notification.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(appNotice);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == appNotice,
                        // ),
                        // buildSectionHeader(context, 'Analytics'),
                        // DrawerListTile(
                        //   title: report,
                        //   svgSrc: "assets/icons/menu_notification.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(report);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == report,
                        // ),
                        // buildSectionHeader(context, 'Settings'),
                        // DrawerListTile(
                        //   title: web_app_setting,
                        //   svgSrc: "assets/icons/menu_setting.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu(web_app_setting);
                        //     menuProvider.controlMenu(context);
                        //   },
                        //   selected: menuProvider.sideMenu == web_app_setting,
                        // ),
                        // buildSectionHeader(context, 'Page management'),
                        // DrawerListTile(
                        //   title: pages,
                        //   svgSrc: "assets/icons/menu_setting.svg",
                        //   press: () {},
                        //   children: [
                        //     DrawerListTile(
                        //       title: aboutUs,
                        //       svgSrc: "assets/icons/menu_setting.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(aboutUs);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected: menuProvider.sideMenu == aboutUs,
                        //     ),
                        //     DrawerListTile(
                        //       title: terms_condition,
                        //       svgSrc: "assets/icons/menu_setting.svg",
                        //       press: () {
                        //         menuProvider.setSideMenu(terms_condition);
                        //         menuProvider.controlMenu(context);
                        //       },
                        //       selected:
                        //           menuProvider.sideMenu == terms_condition,
                        //     ),
                        //   ],
                        // ),
                        // buildSectionHeader(context, 'Account'),
                        // DrawerListTile(
                        //   title: "Profile",
                        //   svgSrc: "assets/icons/menu_profile.svg",
                        //   press: () {
                        //     menuProvider.setSideMenu('Profile');
                        //     menuProvider.controlMenu(context);
                        //   },
                        // ),
                        // DrawerListTile(
                        //   title: "Logout",
                        //   svgSrc: "assets/icons/menu_setting.svg",
                        //   press: () {
                        //     _authProvider.clearUser();
                        //     context.go(RoutePath.login);
                        //   },
                        // ),
                        height50(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            capText('@Copyright 2023'),
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

  Widget buildDrawerListTile(
      String title, String svgIcon, MenuProvider menuProvider,
      [bool expansion = false, List<Widget>? children]) {
    return Builder(builder: (context) {
      return DrawerListTile(
        title: title,
        svgSrc: "assets/icons/$svgIcon",
        press: () {
          if (!expansion) {
            menuProvider.setSideMenu(title);
            menuProvider.controlMenu(context);
          }
        },
        selected: !expansion ? menuProvider.sideMenu == title : false,
        children: [if (children != null) ...children.map((e) => e).toList()],
      );
    });
  }

  Column buildSectionHeader(BuildContext context, String s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height10(),
        bodyMedText(s.split(' ').map((e) => e.capitalize).toList().join(' '),
            color: getTheme.colorScheme.primary),
        height5(),
      ],
    );
  }
}

class DrawerListTile extends StatefulWidget {
  DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    this.selected = false,
    this.children,
  }) : super(key: key) {
    children = children ?? [];
  }

  final String title, svgSrc;
  final VoidCallback press;
  List<Widget>? children;
  final bool selected;
  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool expanded = false;
  // late ExpansionTileController controller;

  @override
  void initState() {
    // controller=ExpansionTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;
    var leading = SvgPicture.asset(
      widget.svgSrc,
      color: darkMode ? Colors.white54 : Colors.black54,
      height: 16,
    );
    var title = Text(
      widget.title,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          // fontWeight: FontWeight.w600,
          height: 1,
          color: getTheme.brightness == Brightness.dark
              ? Colors.white70
              : Colors.black),
    );
    var trailing = widget.children!.isEmpty ? const SizedBox.shrink() : null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          widget.children!.isNotEmpty
              ? ExpansionTile(
                  // controller: controller,
                  controlAffinity: ListTileControlAffinity.platform,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: expanded ? getTheme.colorScheme.primary : null,
                  // backgroundColor: Colors.red,
                  // collapsedBackgroundColor: Colors.blue,
                  onExpansionChanged: (val) {
                    infoLog('from expansion tile');
                    setState(() {
                      expanded = val;
                    });
                  },
                  childrenPadding:
                      EdgeInsetsDirectional.only(start: paddingDefault),
                  leading: leading,
                  title: title,
                  trailing: trailing,
                  children: [
                    ...widget.children!,
                  ],
                )
              : ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: expanded ? getTheme.colorScheme.primary : null,
                  // backgroundColor: Colors.red,
                  // collapsedBackgroundColor: Colors.blue,
                  onTap: () {
                    infoLog('from list tile');
                    widget.press();
                  },
                  leading: leading,
                  title: title,
                ),
          if (widget.selected)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  color: getTheme.colorScheme.primary.withOpacity(0.1),
                ))
        ],
      ),
    );
  }
}
