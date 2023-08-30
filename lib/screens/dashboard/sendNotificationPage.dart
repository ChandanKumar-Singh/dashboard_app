import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import '../../responsive.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/screens/dashboard/components/default_caontainer.dart';
import '/utils/sizedbox_utils.dart';
import '/utils/text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants.dart';

import 'components/profile/profile_header.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authProvider = sl.get<AuthProvider>();

  TextEditingController userController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  List<String> usersList = [];
  String? userType;
  void _onRefresh() async {
    // authProvider.getUserInfo();
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
    setState(() {});
  }

  late void Function(AnimationStatus) _statusListener;

  XFile? image;
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Builder(builder: (context) {
                          var child =
                              _buildNotificationFormCard(context, theme);
                          if (Responsive.isMobile(context)) return child;
                          return Row(
                            mainAxisAlignment: Responsive.isTablet(context)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 700),
                                  child: child),
                            ],
                          );
                        }),
                      ],
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

  Widget _buildNotificationFormCard(BuildContext context, ThemeData theme) {
    return defaultContainer(context,
        padding: EdgeInsets.all(paddingDefault),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  bodyLargeText('Send Notification to '),
                  PopupMenuButton(
                      itemBuilder: (context) => <PopupMenuItem>[
                            ...['Customers', 'Stores', 'Delivery Boy']
                                .map((e) => PopupMenuItem(
                                    value: e, child: bodyMedText(e)))
                                .toList()
                          ],
                      onSelected: (val) => setState(() {
                            userType = val;
                          }),
                      position: PopupMenuPosition.under,
                      offset: const Offset(0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          bodyLargeText(userType ?? 'Select User',
                              color: getTheme.colorScheme.primary),
                          Icon(Icons.arrow_drop_down_rounded,
                              color: getTheme.colorScheme.primary)
                        ],
                      )),
                ],
              ),
              height10(),
              bodyMedText('Select ${userType ?? 'User Type'}',
                  color: Colors.grey),
              height5(),
              Column(
                children: [
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      ...usersList.map(
                        (e) => Chip(
                          label: capText(e),
                          onDeleted: () => setState(() => usersList.remove(e)),
                          deleteIcon: const Icon(Icons.clear, size: 15),
                        ),
                      ),
                    ],
                  ),
                  if (usersList.isNotEmpty) height10()
                ],
              ),
              TypeAheadFormField<String>(
                getImmediateSuggestions: true,
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Select ${userType ?? 'User Type'}')),
                suggestionsCallback: (pattern) async =>
                    generateRandomNames(pattern),
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                errorBuilder: (BuildContext context, Object? error) => Text(
                    '$error',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error)),
                suggestionsBoxDecoration:
                    const SuggestionsBoxDecoration(elevation: 0.0),
                onSuggestionSelected: onSuggestionSelect,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
                loadingBuilder: (ctx) => defaultContainer(
                  context,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 150, minHeight: 100),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
                layoutArchitecture: (items, scrollController) {
                  return defaultContainer(
                    context,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [...items.toList()]),
                    ),
                  );
                },
              ),
              height10(),
              bodyMedText('Title', color: Colors.grey),
              height5(),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.edit), hintText: 'Enter title'),
              ),
              height10(),
              bodyMedText('Message', color: Colors.grey),
              height5(),
              TextFormField(
                maxLines: 5,
                maxLength: 1000,
                style: const TextStyle(fontSize: 13),
                decoration:
                    const InputDecoration(hintText: 'Enter message here'),
              ),
              height10(),
              bodyMedText('Notification Image', color: Colors.grey),
              height5(),
              TextFormField(
                readOnly: true,
                controller: imageController,
                decoration: InputDecoration(
                    suffixIcon: SizedBox(
                        height: 25,
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () async {
                                final XFile? pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  image = pickedImage;
                                  setState(() {
                                    imageController.text =
                                        image!.path.split('/').last;
                                  });
                                }
                              },
                              style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text('Pick'),
                            ),
                          ],
                        )),
                    prefixIcon: const Icon(Icons.photo),
                    hintText: 'Select an image'),
              ),
              if (image != null)
                Column(
                  children: [
                    height10(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 200, maxWidth: 250),
                        child: Image.network(image!.path),
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
                        _formKey.currentState?.validate();
                      },
                      child: bodyLargeText('Confirm & Send',
                          color: Colors.white)),
                ],
              ),
            ],
          ),
        ));
  }

  Future<List<String>> generateRandomNames(String startingLetter,
      [int numberOfNames = 20]) async {
    List<String> names = ['All', "All Users", 'All Stores', 'All Delivery Boy'];
    for (int i = 0; i < numberOfNames; i++) {
      names.add(
          "${userType ?? ''}$startingLetter${Random().nextInt(3)}${Random().nextInt(3)}");
    }
    await Future.delayed(const Duration(seconds: 1));
    return names;
  }

  void onSuggestionSelect(String sg) {
    if (['All', "All Users", 'All Stores', 'All Delivery Boy']
        .any((element) => element == sg)) {
      setState(() {
        _typeAheadController.text = sg;
        usersList.clear();
      });
      return;
    }
    _typeAheadController.clear();
    setState(() {
      usersList.add(sg);
    });
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
                          const BoxConstraints(maxHeight: 200, maxWidth: 500),
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
                          const BoxConstraints(maxHeight: 200, maxWidth: 500),
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
