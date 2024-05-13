import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'firebase_options.dart';

late Box dataBox;

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
              onPressed: () {},
              child: const Text('Go to SignUpScreen'),
            ),
            TextButton(
              onPressed: () {},
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
              onPressed: () {},
              child: const Text('Go to UserPageScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdSearchScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdFeedScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdDetailScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to CameraScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to PictureCropScreen'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Go to OotdPostScreen'),
            ),
            const Spacer(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
