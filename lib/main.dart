import 'package:dmpuzzle/ui/page/dm_game/dm_game_page.dart';
import 'package:dmpuzzle/ui/svc/global/app_route.dart';
import 'package:dmpuzzle/ui/svc/global/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
          create: (_) => ThemeModel(),
        ),
      ],
      child: DmGameApp(),
    ),
  );
}

class DmGameApp extends StatefulWidget {
  DmGameApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _DmGameAppState? state = context.findAncestorStateOfType<_DmGameAppState>();
  }

  @override
  _DmGameAppState createState() => _DmGameAppState();
}

class _DmGameAppState extends State<DmGameApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onDispose() {}

  refreshState() {
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DM Puzzle Game',
      theme: Provider.of<ThemeModel>(context).getCurrentTheme(),
      home: SafeArea(
        child: DmGameGridPage(),
      ),
      onGenerateRoute: AppRoute.generateRoute,
      initialRoute: AppRoute.DmGameRoute,
    );
  }
}
