import 'package:fashion/bloc_observer.dart';
import 'package:fashion/core/local_save_storege/cache_helper.dart';
import 'package:fashion/core/remote/dio_helper.dart';
import 'package:fashion/core/styles/themes.dart';
import 'package:fashion/features/auth/cubit/cubit.dart';
import 'package:fashion/features/auth/cubit/states.dart';
import 'package:fashion/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit,AppLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeService().lightTheme,
          darkTheme: ThemeService().darkTheme,
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
        );
      },
      ),
    );
  }
}

