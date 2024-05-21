import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/core/hive/hive_wrapper.dart';
import 'package:weaco/presentation/common/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  HiveWrapper.dataBox = await Hive.openBox('weacoBox');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
  runApp(const WeacoApp());
}

class WeacoApp extends StatelessWidget {
  const WeacoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => getIt<UserProvider>(),
      child: MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('ko', 'KR')],
        locale: const Locale('ko'),
        title: 'WeaCo',
        theme: ThemeData(
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 22),
            headlineMedium: TextStyle(fontSize: 18),
            headlineSmall: TextStyle(fontSize: 14),
            bodyLarge: TextStyle(fontSize: 12),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF2C347)),
          primaryColor: const Color(0xffF2C347),
          canvasColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xffF5F5F5),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
