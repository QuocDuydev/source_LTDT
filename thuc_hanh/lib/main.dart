import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/providers/diachimodel.dart';
import 'package:thuc_hanh/providers/dkhocphanviewmodel.dart';
import 'package:thuc_hanh/providers/forgotviewmodel.dart';
import 'package:thuc_hanh/providers/loginviewmodel.dart';
import 'package:thuc_hanh/providers/mainviewmodel.dart';
import 'package:thuc_hanh/providers/profileviewmodel.dart';
import 'package:thuc_hanh/providers/registerviewmodel.dart';
import 'package:thuc_hanh/services/api_service.dart';
import 'package:thuc_hanh/ui/page_fogot.dart';
import 'package:thuc_hanh/ui/page_main.dart';
import 'package:thuc_hanh/ui/page_register.dart';
import 'package:thuc_hanh/ui/subpagedshocphan.dart';
import 'package:thuc_hanh/ui/subpagedslop.dart';
import 'package:thuc_hanh/ui/subpageprofile.dart';

import 'providers/menubarviewmodel.dart';
import 'ui/page_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService api = ApiService();
  api.initialize();

  Profile profile = Profile();
  profile.initalize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<ForgotViewModel>(
      create: (context) => ForgotViewModel(),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
    ),
    ChangeNotifierProvider<MenuBarViewModel>(
      create: (context) => MenuBarViewModel(),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
    ),
    ChangeNotifierProvider<DiaChiModel>(
      create: (context) => DiaChiModel(),
    ),
    ChangeNotifierProvider<DangKyHocPhanViewModel>(
      create: (context) => DangKyHocPhanViewModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => PageForgot(),
        '/profile': (context) => SubPageProfile(),
        '/dslop': (context) => const SubPageDslop(),
        '/dshocphan': (context) => const SubPageDshocphan(),
        '/dshpdadk': (context) => const SubPageDslop(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageMain(),
    );
  }
}
