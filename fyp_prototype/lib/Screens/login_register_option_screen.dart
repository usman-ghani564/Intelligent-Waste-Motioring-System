import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp_prototype/Screens/login_register_form_screen.dart';
import 'package:lottie/lottie.dart';

class LoginRegisterOptionScreen extends StatelessWidget {
  Function signin;
  Function signup;
  Function signout;
  LoginRegisterOptionScreen(this.signin, this.signup, this.signout);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AdaptiveTheme.of(context).theme.backgroundColor,
        child: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Lottie.asset('assets/garbage_truck_lottie.json'),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegisterFormScreen(
                          'loginUser', signin, signup, signout),
                    ),
                  );
                },
                child: filledNeonButton(context, 'Login User')),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegisterFormScreen(
                          'loginAdmin', signin, signup, signout),
                    ),
                  );
                },
                child: filledNeonButton(context, 'Login Admin')),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegisterFormScreen(
                          'signupUser', signin, signup, signout),
                    ),
                  );
                },
                child: outlinedNeonButton(context, 'Signup User')),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginRegisterFormScreen(
                          'signupAdmin', signin, signup, signout),
                    ),
                  );
                },
                child: outlinedNeonButton(context, 'Signup Admin')),
          ],
        ),
      ),
    );
  }

  Align filledNeonButton(BuildContext context, String buttonName) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.7,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFCCFF00),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Align outlinedNeonButton(BuildContext context, String buttonName) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.7,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: const Color(0xFFCCFF00),
            width: 2,
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color getThemeMode(BuildContext context) {
    return AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black;
  }
}
