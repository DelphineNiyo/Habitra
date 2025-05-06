import 'package:flutter/material.dart';
import 'features/startup/pages/splash_screen.dart';
import 'app/routes.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  //await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: 'https://cygbpjvablisssbgekoi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN5Z2JwanZhYmxpc3NzYmdla29pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1NTU2NTMsImV4cCI6MjA2MjEzMTY1M30.aumGine3dwE-vI3gC_z8t5SXRVnon9DSsrkDicWX_D0',
  );
  


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        textTheme: const TextTheme(
          displayLarge: AppText.heading1,
          displayMedium: AppText.heading2,
          displaySmall: AppText.heading3,
          bodyLarge: AppText.bodyLarge,
          bodyMedium: AppText.bodyMedium,
          bodySmall: AppText.bodySmall,
          labelLarge: AppText.button,
          labelMedium: AppText.label,
          labelSmall: AppText.caption,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
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
