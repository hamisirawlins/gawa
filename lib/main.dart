import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gawa/firebase_options.dart';
import 'package:gawa/screens/auth/auth_state.dart';
import './screens/collections/personal_collections_screen.dart';
import './screens/collections/group_collections_screen.dart';
import './screens/profile/profile_screen.dart';
import './screens/auth/forgot_password_screen.dart';
import './screens/home/home_screen.dart';
import './screens/auth/register_screen.dart';
import './screens/auth/login_screen.dart';
import './routes/app_routes.dart';
import 'utils/get_screen_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Gawa',
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
      routes: {
        AppRoutes.register: (context) => RegisterScreen(),
        AppRoutes.forgotPassword: (context) => ForgotPasswordScreen(),
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.groupCollections: (context) => GroupCollectionsScreen(),
        AppRoutes.personalCollections: (context) => PersonalCollectionsScreen(),
      },
    );
  }
}
