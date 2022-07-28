import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';

import 'features/todoApp/presentation/pages/on_board_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      supportedLocales: const [
        Locale("en"),
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      home: OnBoardPage(),
    );
  }
}
