/*
import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToRegistration(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => RegistrationPage()),
    // );
  }

  bool showFirstCard = true;

  void _switchCards() {
    setState(() {
      showFirstCard = !showFirstCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0.0, 100 * (1 - _animation.value)),
            child: Opacity(
              opacity: _animation.value,
              child: child,
            ),
          );
        },
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).cardColor),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: showFirstCard
                  ? loginForm(context)
                  : registrationForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Form loginForm(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 100),
          const SizedBox(height: 32.0),
          const TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          const TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
          const SizedBox(height: 16.0),
          TextButton(
            // onPressed: () => _navigateToRegistration(context),
            onPressed: () => _switchCards(),
            child: const Text('Create an Account'),
          ),
        ],
      ),
    );
  }

  Form registrationForm(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(size: 100),
          const SizedBox(height: 32.0),
          const TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          const TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          const TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Register'),
          ),
          const SizedBox(height: 32.0),
          TextButton(
            // onPressed: () => _navigateToRegistration(context),
            onPressed: () => _switchCards(),
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_dashboard/controllers/auth_provider.dart';
import 'package:my_dashboard/database/model/response/base/sl_container.dart';
import 'package:my_dashboard/route_management/route_path.dart';
import 'package:my_dashboard/screens/main/main_screen.dart';
import 'package:my_dashboard/utils/toasts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rscaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _rslideAnimation;
  var authProvider = sl.get<AuthProvider>();

  bool _showLoginCard = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.ease),
      ),
    );
    _rscaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1, curve: Curves.ease),
      ),
    );

    _slideAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(1.0, 0.0))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.ease),
    ));
    _rslideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.ease),
    ));
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController?.close();
    _animationController.dispose();
    super.dispose();
  }

  void _switchCards() {
    setState(() {
      _showLoginCard = !_showLoginCard;
    });

    if (_showLoginCard) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final emailFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();

  int? registered;

  Widget _buildLoginCard(AuthProvider provider) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    const SizedBox(height: 32.0),
                    Form(
                      key: emailFormKey,
                      child: TextFormField(
                        controller: emailController,
                        enabled: !provider.otpSent,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black54)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black54)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black54)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please fill the email address.';
                          } else if (!RegExp(
                                  r'^(?!\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(val)) {
                            return 'Please enter an valid email.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Visibility(
                      visible: provider.otpSent,
                      child: Form(
                          key: otpFormKey,
                          child: _OTPFieldWidget(
                              errorController: errorController,
                              provider: provider,
                              hasError: hasError,
                              callBack: (otp) {
                                setState(() {
                                  currentText = otp ?? '';
                                });
                              })),
                    ),
                    Visibility(
                        child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Didn't receive the code? ",
                                style: Theme.of(context).textTheme.bodyMedium),
                            TextButton(
                              onPressed: () {
                                errorController?.close();
                                provider.setOtpSent(false);
                                snackBar("OTP resend!!", context);
                              },
                              child: const Text(
                                "RESEND",
                                style: TextStyle(
                                  color: Color(0xFF91D3B3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () => _doLogin(provider,currentText,1,context),
                          child: Center(
                            child: Text(
                              provider.otpSent
                                  ? "VERIFY"
                                  : 'SEND OTP'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateUser(AuthProvider provider) {
    return SlideTransition(
      position: _rslideAnimation,
      child: ScaleTransition(
        scale: _rscaleAnimation,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    const SizedBox(height: 32.0),
                    Form(
                      key: updateFormKey,
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter your full name';
                          } else if (RegExp(r'^[a-zA-Z\s]+$]').hasMatch(val)) {
                            return 'Please should contain alphabet and numeric only';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        if (updateFormKey.currentState?.validate() ?? false) {
                          provider
                              .updateProfile(
                                  emailController.text, nameController.text)
                              .then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainScreen()),
                                  (route) => false);
                            }
                          });
                        }
                      },
                      child: const Text('Get Started',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: _switchCards,
                      child: const Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationCard(AuthProvider provider) {
    return SlideTransition(
      position: _rslideAnimation,
      child: ScaleTransition(
        scale: _rscaleAnimation,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: _switchCards,
                      child: const Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _showLoginCard
                  ? _buildLoginCard(provider)
                  : _buildUpdateUser(provider),
            ),
          ),
        );
      },
    );
  }

  void _doLogin(AuthProvider provider, String currentText, int i, BuildContext context) {
  // Navigator.pushAndRemoveUntil(
  //                       context,
  //                       MaterialPageRoute(builder: (context) => MainScreen()),
  //                       (r) => false);
  //
    bool emailValidate = emailFormKey.currentState!.validate();
    if (emailValidate) {
      if (provider.otpSent) {
        if (currentText.length != 6 ||
            !(otpFormKey.currentState?.validate() ?? false)) {
          errorController!.add(ErrorAnimationType.shake);
          setState(() => hasError = true);
        } else {
          setState(
            () {
              hasError = false;
              provider
                 .verifyLoginOTP(emailController.text, currentText,
                  registered ?? 0, context)
               .then((value) {
                if (value) {
                  snackBar("OTP Verified!!", context);
                  if (registered == 1) {
                    currentText = '';
                    errorController = null;
                    registered = null;
                    provider.setOtpSent(false);
                    context.go(RoutePath.home);
                  }
                  else if (registered == 0) {
                    registered = null;
                    currentText = '';
                    errorController = null;
                    provider.setOtpSent(false);
                    _switchCards();
                  }
                }
              });
            },
          );
        }
      }
      else {
        provider.sendLoginOTP(emailController.text).then((value) {
          errorController = StreamController<ErrorAnimationType>();
          registered = value;
        });
      }
    }
  }
}

class _OTPFieldWidget extends StatefulWidget {
  const _OTPFieldWidget({
    Key? key,
    this.errorController,
    required this.callBack,
    required this.provider,
    required this.hasError,
  }) : super(key: key);
  final StreamController<ErrorAnimationType>? errorController;
  final void Function(String? text) callBack;
  final AuthProvider provider;
  final bool hasError;
  @override
  State<_OTPFieldWidget> createState() => _OTPFieldWidgetState();
}

class _OTPFieldWidgetState extends State<_OTPFieldWidget> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: PinCodeTextField(
          appContext: context,
          // pastedTextStyle: TextStyle(
          // color: Colors.green.shade600,
          // fontWeight: FontWeight.bold),
          length: 6,
          // obscureText: true,
          obscuringCharacter: '*',
          obscuringWidget: const FlutterLogo(size: 24),
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          // validator: (v) {
          //   if (v!.length < 6) {
          //     return 'Please fill 6-digit OTP';
          //   } else {
          //     return null;
          //   }
          // },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            // borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: false,
          errorAnimationController: widget.errorController,
          controller: otpController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 10)
          ],
          onCompleted: (v) {
            debugPrint("Completed");
          },
          // onTap: () {
          //   print("Pressed");
          // },
          onChanged: (value) {
            debugPrint(value);
            widget.callBack(otpController.text);
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        ),
      ),
      if (widget.hasError)
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "*Please fill your valid OTP",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
    ]);
  }
}
