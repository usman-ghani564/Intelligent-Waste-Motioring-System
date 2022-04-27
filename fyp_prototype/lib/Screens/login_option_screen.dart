import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:fyp_prototype/Screens/singup_option_screen.dart';
import 'package:fyp_prototype/Screens/user_dashboard.dart';
import 'package:fyp_prototype/Screens/worker_dashobard.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import 'admin_dashboard.dart';

class LoginRegisterOptionScreen extends StatefulWidget {
  Function signin;
  Function signup;
  Function signout;
  Function getuserid;

  LoginRegisterOptionScreen(
    this.signin,
    this.signup,
    this.signout,
    this.getuserid,
  );

  @override
  State<LoginRegisterOptionScreen> createState() =>
      _LoginRegisterOptionScreenState();
}

class _LoginRegisterOptionScreenState extends State<LoginRegisterOptionScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String loginString = 'login User';
  bool userPressed = true;
  bool adminPressed = false;
  bool workerPressed = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AdaptiveTheme.of(context).theme.backgroundColor,
          child: Stack(
            children: [
              Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Lottie.asset('assets/garbage_truck_lottie.json'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  outerContainer(context),
                ],
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget outerContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.55,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
              offset: Offset(
                2.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          setState(() {
                            loginString = 'login User';
                            userPressed = true;
                            adminPressed = false;
                            workerPressed = false;
                          });
                        },
                  child: innerContainer(
                      context,
                      'https://assets2.lottiefiles.com/packages/lf20_ia8jpabk.json',
                      userPressed),
                ),
                InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          setState(() {
                            loginString = 'login Admin';
                            userPressed = false;
                            adminPressed = true;
                            workerPressed = false;
                          });
                        },
                  child: innerContainer(
                      context,
                      'https://assets3.lottiefiles.com/packages/lf20_9iugpxgj.json',
                      adminPressed),
                ),
                InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          setState(() {
                            loginString = 'login Worker';
                            userPressed = false;
                            adminPressed = false;
                            workerPressed = true;
                          });
                        },
                  child: innerContainer(
                      context,
                      'https://assets9.lottiefiles.com/packages/lf20_a10mczgm.json',
                      workerPressed),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              loginString,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0XFF006E7F),
              ),
            ),
            Form(
              key: _formKey,
              child: loginForms(loginString),
            )
          ],
        ),
      ),
    );
  }

  Widget innerContainer(BuildContext context, String imageUrl, bool flag) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          height: 100,
          width: 100,
          child: Lottie.network(imageUrl),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
              bottomLeft: Radius.circular(7.0),
              bottomRight: Radius.circular(7.0),
            ),
          ),
        ),
        flag == false
            ? Container()
            : const Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFFF8CB2E),
                ),
              ),
      ],
    );
  }

  Widget loginForms(String option) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.email, color: Color(0XFF006E7F)),
              labelText: 'email',
              labelStyle: TextStyle(color: Color(0XFF006E7F)),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0XFF006E7F),
              ),
              labelText: 'password',
              labelStyle: TextStyle(color: const Color(0XFF006E7F)),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: isLoading
                    ? null
                    : () {
                        String usertype = '';
                        if (option == 'login User') {
                          usertype = 'user';
                        } else if (option == 'login Admin') {
                          usertype = 'admin';
                        } else if (option == 'login Worker') {
                          usertype = 'worker';
                        }
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          widget
                              .signin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  userType: usertype)
                              .then((val) {
                            if (val == 'Signed In') {
                              if (usertype == 'user') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserDashboard(
                                          widget.signout, widget.getuserid)),
                                );
                              } else if (usertype == 'admin') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDashboard(
                                          widget.signout, widget.getuserid)),
                                );
                              } else if (usertype == 'worker') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkerDashboard(
                                          widget.signout, widget.getuserid)),
                                );
                              }
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => App()),
                              );
                            }
                          });
                        }
                      },
                child: filledNeonButton(context, 'login')),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpOptionScreen(
                              widget.signin,
                              widget.signup,
                              widget.signout,
                              widget.getuserid),
                        ),
                      );
                    },
              child: const Text(
                'Create an account',
                style: TextStyle(
                  color: Color(0xFFEE5007),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Align filledNeonButton(BuildContext context, String buttonName) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.3,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF8CB2E),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
