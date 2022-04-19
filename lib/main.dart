import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/login_service.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/intro/introduction_page.dart';
import 'package:qixer/view/intro/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryStatesService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => BookConfirmationService()),
        ChangeNotifierProvider(create: (_) => BookStepsService()),
        ChangeNotifierProvider(create: (_) => AllServicesService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qixer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
