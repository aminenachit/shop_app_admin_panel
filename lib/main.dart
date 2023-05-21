import 'package:flutter/material.dart';
import 'package:shop_app_admin_panel/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'consts/theme_data.dart';
import 'controllers/MenuController.dart' as xx;
import 'inner_screens/add_prod.dart';
import 'providers/dark_theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDO8jRdGhCxavOVhFATzcbOjUWepRJvWMU",
    projectId: "mediashop-f69cb",
    messagingSenderId: "937666770377",
    appId: "1:937666770377:web:bb9207a513c02eaaaae418",
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => xx.MenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MediaShop',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const MainScreen(),
              routes: {
                UploadProductForm.routeName: (context) =>
                    const UploadProductForm(),
              });
        },
      ),
    );
  }
}
