import 'dart:async';

import 'package:flutter/material.dart';
import '/database/model/response/additional/user_model.dart';

import '../database/model/response/base/sl_container.dart';
import '../database/repositories/auth_repo.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({super.key, required super.child})
      : super(notifier: StreamAuthNotifier());

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((UserModel? user) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// An asynchronous log in services mock with stream similar to google_sign_in.
///
/// This class adds an artificial delay of 3 second when logging in an user, and
/// will automatically clear the login session after [refreshInterval].
class StreamAuth {
  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth({this.refreshInterval = 20})
      : _userStreamController = StreamController<UserModel?>.broadcast() {
    _userStreamController.stream.listen((UserModel? currentUser) {
      _currentUser = currentUser;
    });
  }

  /// The current user.
  UserModel? get currentUser => _currentUser;
  UserModel? _currentUser;

  /// Checks whether current user is signed in with an artificial delay to mimic
  /// async operation.
  Future<bool> isSignedIn() async {
    // await Future<void>.delayed(const Duration(seconds: 1));
    var authRepo = sl.get<AuthRepo>();
    _currentUser = await authRepo.getUser();
    return _currentUser != null;
  }

  /// A stream that notifies when current user has changed.
  Stream<UserModel?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<UserModel?> _userStreamController;

  /// The interval that automatically signs out the user.
  final int refreshInterval;

  Timer? _timer;
  Timer _createRefreshTimer() {
    return Timer(Duration(seconds: refreshInterval), () {
      _userStreamController.add(null);
      _timer = null;
    });
  }

  /// Signs in a user with an artificial delay to mimic async operation.
  Future<void> signIn(UserModel userData,
      {bool onBoarding = false, int bottomIndex = 0}) async {
    var authRepo = sl.get<AuthRepo>();
    await authRepo.saveUser(userData);
    UserModel? user = await authRepo.getUser();
    if (user != null) {
      //   MyDialogs.showCircleLoader();
      // }
      await Future<void>.delayed(const Duration(seconds: 3));
      // Get.back();
      _userStreamController.add(user);
      // sl.get<DashboardProvider>().setBottomIndex(bottomIndex);
    }
    _timer?.cancel();
    // _timer = _createRefreshTimer();
  }

  /// Signs out the current user.
  Future<void> signOut({bool onBoarding = false}) async {
    //todo: remove this after testing on-boarding screen
    _timer?.cancel();
    _timer = null;
    var authRepo = sl.get<AuthRepo>();
    await authRepo.clearUser();
    _userStreamController.add(await authRepo.getUser());
  }
}
