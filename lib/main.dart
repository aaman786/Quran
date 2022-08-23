import 'package:compass/provider/provider.dart';
import 'package:compass/screens/surah.dart';
import 'package:compass/screens/verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VerseProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Compass',
        theme: ThemeData.dark().copyWith(
            primaryColor: const Color.fromARGB(255, 20, 157, 125),
            brightness: Brightness.dark),
        initialRoute: '/',
        routes: {
          '/': (_) => const SurahScreen(),
          'verse': (_) => VerseScreen(),
        },
      ),
    );
  }
}
