import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'package:weaco/presentation/navigation_bar/floating_action_button_widget.dart';
import 'firebase_options.dart';
import 'presentation/common/user_provider.dart';

late Box<String> dataBox;

void main() async {
  await Hive.initFlutter();
  dataBox = await Hive.openBox('weacoBox');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => getIt<UserProvider>(),
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
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
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xffF2C347)),
            primaryColor: const Color(0xffF2C347),
            canvasColor: Colors.white,
            scaffoldBackgroundColor: const Color(0xffF5F5F5),
            useMaterial3: true,
          ),
          routerConfig: router,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool isPressingFloatingActionButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => RouterStatic.goToHome(context),
              child: const Text('Go to HomeScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToSignUp(context),
              child: const Text('Go to SignUpScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToSignIn(context),
              child: const Text('Go to SignInScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to DialogScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.pushToAppSetting(context),
              child: const Text('Go to AppSettingScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToMyPage(context),
              child: const Text('Go to MyPageScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToUserPage(context),
              child: const Text('Go to UserPageScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToOotdSearch(context),
              child: const Text('Go to OotdSearchScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToOotdFeed(context),
              child: const Text('Go to OotdFeedScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdDetailScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToCamera(context),
              child: const Text('Go to CameraScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToPictureCrop(context, ''),
              child: const Text('Go to PictureCropScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToOotdPost(context),
              child: const Text('Go to OotdPostScreen'),
            ),
            const Spacer(),
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingActionButtonWidget(),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
