import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamyar/view/SignUpPage.dart';
import 'package:supabase/supabase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      final supabaseClient = SupabaseClient(
        'https://sauzexiguejrtjahrkda.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhdXpleGlndWVqcnRqYWhya2RhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI0NzY2MjEsImV4cCI6MjAwODA1MjYyMX0.Lrgeo3xpUhuCSDVkd_c228Wl5dXtTt5x1XXacGYb6Fk',
      );

      //Get.to(const MainScreen());
      Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignUpPage(client: supabaseClient),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 3.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/unilogo.png',
              height: size.height / 4,
              width: size.width / 4,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          //Loading Section
          Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: size.height / 13,
            ),
          ),
          SizedBox(
            height: size.height / 7,
          ),
          Text(
            'سیستم هوشمند همیار',
            style:
                TextStyle(fontFamily: 'nastaliq', fontSize: size.height / 15),
          )
        ],
      ),
    );
  }
}
