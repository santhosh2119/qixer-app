import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/auth_services/change_pass_service.dart';
import 'package:qixer/service/auth_services/google_sign_service.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/service/auth_services/logout_service.dart';
import 'package:qixer/service/auth_services/reset_password_service.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/service/leave_feedback_service.dart';
import 'package:qixer/service/pay_services/bank_transfer_service.dart';
import 'package:qixer/service/pay_services/payment_service.dart';
import 'package:qixer/service/pay_services/stripe_service.dart';
import 'package:qixer/service/profile_edit_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/saved_items_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/intro/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeService().publishableKey;
  await Stripe.instance.applySettings();

  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => SliderService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => TopRatedServicesSerivce()),
        ChangeNotifierProvider(create: (_) => ProfileEditService()),
        ChangeNotifierProvider(create: (_) => RecentServicesService()),
        ChangeNotifierProvider(create: (_) => SavedItemService()),
        ChangeNotifierProvider(create: (_) => ServiceDetailsService()),
        ChangeNotifierProvider(create: (_) => LeaveFeedbackService()),
        ChangeNotifierProvider(create: (_) => GoogleSignInService()),
        ChangeNotifierProvider(create: (_) => PaymentService()),
        ChangeNotifierProvider(create: (_) => StripeService()),
        ChangeNotifierProvider(create: (_) => BankTransferService()),
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
