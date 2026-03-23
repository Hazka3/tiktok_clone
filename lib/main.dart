import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/router.dart';
import 'package:tiktok_clone/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoConfig(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'TikTok clone',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottomAppBarTheme: BottomAppBarThemeData(
            color: Colors.grey.shade900,
            surfaceTintColor: Colors.transparent,
          ),
          tabBarTheme: const TabBarThemeData(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          bottomAppBarTheme: const BottomAppBarThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          tabBarTheme: const TabBarThemeData(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
