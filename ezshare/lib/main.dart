import 'package:ezshare/Providers/authenticationprovider.dart';
import 'package:ezshare/Providers/messageprovider.dart';
import 'package:ezshare/Providers/ridecreateprovider.dart';
import 'package:ezshare/aftersplashscreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageCardProvider()),
        ChangeNotifierProvider(create: (_) => RideCreateProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider())
      ],
      child: MaterialApp(
        title: 'Ezshare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const SplashScreen(title: '',),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    
     
  }


  @override
  Widget build(BuildContext context) {
    
    return AnimatedSplashScreen( 
        splashIconSize: 1000,
        duration: 4000,
        centered: true,
        splash: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Center(
                  child: Image.asset(
                    "assets/images/splashicon.png",
                    width: 153,
                    height: 153,
                  ),
                ),
                const SizedBox(height: 200),
                Text(
                  "Made By 3A Developers",
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        nextScreen: const AfterSplashScreenLoader(),
        splashTransition: SplashTransition.scaleTransition,
        animationDuration: const Duration(seconds: 2),
        backgroundColor: Colors.white);
  }
}
