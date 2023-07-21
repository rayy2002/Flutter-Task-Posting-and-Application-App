import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'layout/screen_layout.dart';
import 'providers/user_details_provider.dart';
import 'screens/sign_in_screen.dart';
import 'utils/color_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "YOUR API KEY",
          authDomain: "YOUR AUTH DOMAIN",
          projectId: "YOUR PROJECT ID",
          storageBucket: "YOUR STORAGE BUCKET",
          messagingSenderId: "YOUR MESSAFE SENDER ID",
          appId: "YOUR APP ID"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const Jobby());
}

class Jobby extends StatelessWidget {
  const Jobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "Jobby",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}
