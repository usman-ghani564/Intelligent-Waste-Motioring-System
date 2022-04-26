import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp_prototype/Screens/user_dashboard.dart';
import 'package:fyp_prototype/Screens/login_register_option_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp_prototype/providers/authentication_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

late FirebaseApp firebaseApp;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: const Color(0XFF006E7F),
        primarySwatch: Colors.red,
      ),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(
              FirebaseAuth.instance,
              FirebaseDatabase.instanceFor(
                  app: firebaseApp,
                  databaseURL:
                      'https://fyp-project-98f0f-default-rtdb.asia-southeast1.firebasedatabase.app')),
          child: AuthenticationWrapper(),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  bool signedIn = false;
  AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        widget.signedIn = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.signedIn
        ? UserDashboard(
            context.read<AuthenticationProvider>().signOut,
            context.read<AuthenticationProvider>().getUserId,
          )
        : LoginRegisterOptionScreen(
            context.read<AuthenticationProvider>().signin,
            context.read<AuthenticationProvider>().signUp,
            context.read<AuthenticationProvider>().signOut,
            context.read<AuthenticationProvider>().getUserId);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}
