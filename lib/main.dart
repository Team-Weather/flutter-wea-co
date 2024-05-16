import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'firebase_options.dart';

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
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      locale: const Locale('ko'),
      title: 'WeaCo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF2C347)),
        primaryColor: const Color(0xffF2C347),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xffF5F5F5),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
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
              onPressed: () {},
              child: const Text('Go to AppSettingScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to MyPageScreen'),
            ),
            TextButton(
              onPressed: () {
                context.push(RouterPath.userPage.path);
              },
              child: const Text('Go to UserPageScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdSearchScreen'),
            ),
            TextButton(
              onPressed: () => RouterStatic.goToOotdFeed(context),
              child: const Text('Go to OotdFeedScreen'),
            ),
            TextButton(
              onPressed: () {  },
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
      floatingActionButton: Stack(
        children: [
          if (!isPressingFloatingActionButton)
            SizedBox(
              width: 72,
              height: 72,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isPressingFloatingActionButton = true;
                  });
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    setState(() {
                      isPressingFloatingActionButton = false;
                    });
                  });
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                ),
                backgroundColor: Theme.of(context).canvasColor,
                child: const Icon(
                  Icons.add,
                  color: Color(0xffF2C347),
                  size: 40,
                ),
              ),
            ),
          if (isPressingFloatingActionButton)
            SizedBox(
              width: 128,
              height: 72,
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                backgroundColor: Theme.of(context).canvasColor,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Color(0xffF2C347),
                      size: 40,
                    ),
                    Icon(
                      Icons.photo_album_outlined,
                      color: Color(0xffF2C347),
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
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
