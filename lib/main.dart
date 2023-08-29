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
  runApp(StreamAuthScope(child: MyApp()));
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        inputDecorationTheme: buildInputDecorationTheme(Brightness.light),
        listTileTheme: ListTileTheme.of(context).copyWith(dense: true),
        visualDensity: VisualDensity.compact,
      ),
      dark: ThemeData.dark().copyWith(
        useMaterial3: true,
        visualDensity: VisualDensity.compact,
        listTileTheme: ListTileTheme.of(context).copyWith(dense: true),
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
        inputDecorationTheme: buildInputDecorationTheme(Brightness.dark),

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

InputDecorationTheme buildInputDecorationTheme(Brightness brightness) {
  Color labelColor =
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  Color hintColor =
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  Color focusedBorderColor =
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  Color fillColor = brightness != Brightness.dark
      ? Colors.grey[100]!
      : Colors.white.withOpacity(0.03);
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0));
  InputBorder focus({Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(color: color ?? focusedBorderColor),
      borderRadius: borderRadius);
  InputBorder enable({Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(color: color ?? focusedBorderColor),
      borderRadius: borderRadius);
  InputBorder error({Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(color: color ?? focusedBorderColor),
      borderRadius: borderRadius);
  InputBorder disable({Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(color: color ?? focusedBorderColor),
      borderRadius: borderRadius);
  return InputDecorationTheme(
      isDense: true,
      contentPadding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
      filled: true,
      fillColor: fillColor,
      labelStyle: TextStyle(color: labelColor),
      hintStyle: TextStyle(color: hintColor),
      focusedBorder: focus(),
      enabledBorder: enable(),
      errorBorder: error(color: Colors.red),
      disabledBorder: disable(color: Colors.grey));
}
