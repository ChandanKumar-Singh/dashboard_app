import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_dashboard/constants/app_constants.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/utils/logger.dart';
import 'package:my_dashboard/utils/picture_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/MenuProvider.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);
  var authProvider = sl.get<AuthProvider>();
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 60,
          padding: EdgeInsets.symmetric(
              vertical: Responsive.isMobile(context) ? 0 : defaultPadding / 2),
          child: Row(
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
              if (!Responsive.isMobile(context))
                Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              const Expanded(child: SearchField()),
              ProfileCard()
            ],
          ),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        var authProvider = sl.get<AuthProvider>();
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
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child:
                // authProvider.user.profileImage != null
                '1' != 1
                    ? SizedBox(
                  height: 30,
                      child:   buildCachedNetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVLpYjzbcJkOfAsLdoC4HVA--cVGhgijlUCaHRyt0ACkYn0qMs6rgc2nrv9vYGfCE22k&usqp=CAU',
                          shape: BoxShape.circle),)
                    : Image.asset("assets/images/profile_pic.png",
                        height: isMobile ? 30 : 38),
              ),
              if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text('authProvider.user.fullname' ?? ""),
                ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        );
      },
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: 5),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
