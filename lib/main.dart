import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gawa/core/secrets/app_secrets.dart';
import 'package:gawa/modules/auth/data/datasources/auth_remote_data.dart';
import 'package:gawa/modules/auth/data/repository/auth_repo_impl.dart';
import 'package:gawa/modules/auth/presentiation/pages/auth_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modules/auth/domain/usecases/user_sign_up.dart';
import 'modules/auth/presentiation/bloc/auth_bloc.dart';
import 'utils/get_screen_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    debug: true,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(AuthRepoImpl(
              AuthRemoteDataImpl(supabaseClient: supabase.client))),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const MaterialApp(
      title: 'Gawa',
      debugShowCheckedModeBanner: false,
      home: LoginAndRegisterView(),
      routes: {},
    );
  }
}
