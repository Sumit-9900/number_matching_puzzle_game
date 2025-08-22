import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_matching_puzzle_game/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:number_matching_puzzle_game/pages/game_page.dart';
import 'package:number_matching_puzzle_game/viewmodel/game_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        title: 'Number Matching',
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const GamePage(),
      ),
    );
  }
}
