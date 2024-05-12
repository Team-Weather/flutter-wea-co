import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/home/home_screen.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'firebase_options.dart';

late Box dataBox;

void main() async {
  await Hive.initFlutter();
  dataBox = await Hive.openBox('weacoBox');
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffF2C347)),
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

  final List<Widget> pages = [
    const HomeScreen(),
    const HomeScreen(),
    Container(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () => RouterStatic.goToHome(context),
              child: const Text('Go to HomeScreen')),
          pages[_currentIndex],
        ],
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
                      color: Theme.of(context).primaryColor,
                      width: deviceWidth * 0.005),
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
                      width: deviceWidth * 0.005),
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
