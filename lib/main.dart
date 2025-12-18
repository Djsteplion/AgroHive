import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/social_provider.dart';
import 'providers/product_provider.dart';
import 'screens/main_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/second_screen.dart';
import 'providers/theme_provider.dart';

void main() async {
  // Ensure Flutter bindings are initialized before async calls
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize providers and load data
  final socialProvider = SocialProvider();
  final productProvider = ProductProvider();
  await socialProvider.loadData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => socialProvider),
        ChangeNotifierProvider(create: (_) => productProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access socialProvider to check login status
    final socialProvider = Provider.of<SocialProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrohive',
      
      // FORCING LIGHT THEME:
      // 1. Define the Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      
      // 2. Set darkTheme to null or omit it
      darkTheme: null, 
      
      // 3. Force the mode to light regardless of system settings
      themeMode: ThemeMode.light,

      // Initial route logic
      initialRoute: socialProvider.currentUser != null ? '/mainScreen' : '/onBoardingScreen',
      
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/onBoardingScreen': (context) => const SecondScreen(),
        '/mainScreen': (context) => const MainScreen(),
      },
    );
  }
}