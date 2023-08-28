
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/route_management/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void checkLogin() async {
/*    var authProvider = sl.get<AuthProvider>();
    var token = await authProvider.authRepo.getLoginToken();
    var userData = await authProvider.authRepo.getUser();
    infoLog('check login token $token, userdata $userData');
    if (token != null && userData != null) {
      authProvider.updateUser(userData);
      authProvider.authRepo.updateHeader(token);
      // authProvider.getUserInfo();*/
      Future.delayed(
          const Duration(seconds: 3),
          () => context.go(RoutePath.home));
/*    } else {
      Future.delayed(
          const Duration(seconds: 3),
          () => context.goNamed(RoutePath.login));
    }*/
  }
}
