import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroflix/pages/auth_login.dart';
import 'package:heroflix/pages/movie_detail.dart';
import 'package:heroflix/providers/auth.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';

import './pages/add_product_page.dart';
import './pages/edit_product_page.dart';

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
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        )
    ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: const Color(0xFF37325B),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          AddProductPage.route: (ctx) => AddProductPage(),
          EditProductPage.route: (ctx) => EditProductPage(),
          // MovieDetail.route: (ctx) => MovieDetail(),
        },
      ),
    );
  }
}