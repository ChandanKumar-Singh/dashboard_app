import 'package:adaptive_theme/adaptive_theme.dart';
import '/controllers/MenuProvider.dart';
import '/constants.dart';
import '/controllers/auth_provider.dart';
import '/database/model/response/base/sl_container.dart';
import '/route_management/my_router.dart';
import '/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/services/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initRepos();
  runApp(StreamAuthScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: creamColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          canvasColor: snowColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink)),
      dark: ThemeData.dark().copyWith(
        useMaterial3: true,

        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)
        //     .copyWith(brightness: Brightness.dark),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuProvider()),
          ChangeNotifierProvider(
              create: (context) => AuthProvider(authRepo: sl())),
        ],
        child: MaterialApp.router(
          routerDelegate: MyRouter.router.routerDelegate,
          routeInformationProvider: MyRouter.router.routeInformationProvider,
          routeInformationParser: MyRouter.router.routeInformationParser,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          // ChangeNotifierProvider(
          //   create: (context) => MyMenuController(),
          // ),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
