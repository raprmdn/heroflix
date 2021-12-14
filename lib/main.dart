import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroflix/pages/auth_login.dart';
import 'package:heroflix/providers/auth.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Movies(),
        ),
    ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: const AppBarTheme(
            color: Color(0xff1B1E25),
          ),
          scaffoldBackgroundColor: const Color(0xff1B1E25),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}