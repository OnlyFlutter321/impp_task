import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impp_task/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Thank you so much For this opportiunity",
          style: GoogleFonts.ptMono(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
