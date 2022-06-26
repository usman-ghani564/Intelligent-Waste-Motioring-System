import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp_prototype/Screens/admin_dashboard.dart';
import 'package:fyp_prototype/Screens/user_dashboard.dart';
import 'package:fyp_prototype/Screens/login_option_screen.dart';
import 'package:fyp_prototype/main.dart';
import 'package:fyp_prototype/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class LoginRegisterFormScreen extends StatefulWidget {
  String _optionSelected =
      ""; //This string will have values like loginuser, signup admin etc to show screens based on that
  late Function signin;
  late Function signup;
  late Function signout;
  late Function getuserid;

  LoginRegisterFormScreen(
      String op, Function sIn, Function sUp, Function sout, Function getuid) {
    _optionSelected = op;
    signin = sIn;
    signup = sUp;
    signout = sout;
    getuserid = getuid;
  }

  @override
  _LoginRegisterFormScreenState createState() =>
      _LoginRegisterFormScreenState();
}

class _LoginRegisterFormScreenState extends State<LoginRegisterFormScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFF2C3539),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: selectScreen(),
            color: const Color(0XFF2C3539),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Widget selectScreen() {
    if (widget._optionSelected == 'loginUser') {
      return Form(
        key: _formKey,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFFCCFF00),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: /*SvgPicture.asset('assets/burgundy_122.svg',
                    semanticsLabel: 'Two people garbage collection',
                    fit: BoxFit.scaleDown),*/
                            Image.asset('assets/burgundy_122.png')),
                    const SizedBox(
                      height: 70,
                    ),
                    loginForms(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginRegisterOptionScreen(
                                            widget.signin,
                                            widget.signup,
                                            widget.signout,
                                            widget.getuserid)));
                          },
                          child: const Text('more actions',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              widget
                                  .signin(
                                email: emailController.text,
                                password: passwordController.text,
                                userType: 'user',
                              )
                                  .then((val) {
                                if (val == 'Wrong Credentials!') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => App()),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDashboard(
                                            widget.signout, widget.getuserid),
                                      ));
                                }
                              });
                            }
                          },
                          child: const Text(
                            'login',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFCCFF00),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      );
    } else if (widget._optionSelected == 'loginAdmin') {
      return Form(
        key: _formKey,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFFCCFF00),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/burgundy_128.png'),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    loginForms(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginRegisterOptionScreen(
                                          widget.signin,
                                          widget.signup,
                                          widget.signout,
                                          widget.getuserid)),
                            );
                          },
                          child: const Text('more actions',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              widget
                                  .signin(
                                email: emailController.text,
                                password: passwordController.text,
                                userType: 'admin',
                              )
                                  .then((val) {
                                if (val == 'Wrong Credentials!') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => App()),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminDashboard(
                                            widget.signout, widget.getuserid),
                                      ));
                                }
                              });
                            }
                          },
                          child: const Text(
                            'login',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFCCFF00),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      );
    } else if (widget._optionSelected == 'signupUser') {
      return Form(
        key: _formKey,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFFCCFF00),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/register_one.png')),
                    const SizedBox(
                      height: 70,
                    ),
                    signupForms(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginRegisterOptionScreen(
                                  widget.signin,
                                  widget.signup,
                                  widget.signout,
                                  widget.getuserid,
                                ),
                              ),
                            );
                          },
                          child: const Text('more actions',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              widget
                                  .signup(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      userType: 'user')
                                  .then((val) {
                                if (val == 'Signed Up') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDashboard(
                                            widget.signout, widget.getuserid)),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => App()),
                                  );
                                }
                              });
                            }
                          },
                          child: const Text(
                            'sign up',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFCCFF00),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      );
    } else if (widget._optionSelected == 'signupAdmin') {
      return Form(
        key: _formKey,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFFCCFF00),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/register_2.png')),
                    const SizedBox(
                      height: 70,
                    ),
                    signupForms(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginRegisterOptionScreen(
                                  widget.signin,
                                  widget.signup,
                                  widget.signout,
                                  widget.getuserid,
                                ),
                              ),
                            );
                          },
                          child: const Text('more actions',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              widget.signup(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  userType: 'admin');
                            }
                          },
                          child: const Text(
                            'sign up',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFCCFF00),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      );
    }
    return Container();
  }

  Widget loginForms() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              labelText: 'email',
              labelStyle: TextStyle(color: Colors.white),
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
            style: const TextStyle(color: Colors.white),
            controller: passwordController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              labelText: 'password',
              labelStyle: TextStyle(color: Colors.white),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget signupForms() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.email, color: Colors.white),
              labelText: 'email',
              labelStyle: TextStyle(color: Colors.white),
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
            style: const TextStyle(color: Colors.white),
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              labelText: 'password',
              labelStyle: TextStyle(color: Colors.white),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
