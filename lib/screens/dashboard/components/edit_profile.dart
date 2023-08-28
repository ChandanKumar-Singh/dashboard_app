import 'package:flutter/material.dart';
import 'package:my_dashboard/utils/text.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
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
            "Update Profile",
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
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://assets.justinmind.com/wp-content/webp-express/webp-images/uploads/2020/02/dashboard-example-podcast-insoft.png.webp'),
                            fit: BoxFit.cover)),
                    height: 100,
                    width: 100,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton.filled(
                          onPressed: () {}, icon: const Icon(Icons.edit)))
                ],
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  onPressed: () {}, child: capText('Cancel', context)),
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
