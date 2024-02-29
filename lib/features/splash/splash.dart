import 'package:fashion/core/local_save_storege/cache_helper.dart';
import 'package:fashion/features/auth/login/login.dart';
import 'package:fashion/features/home/view/home.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/navigation.dart';
import '../../core/widgets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      token = CacheHelper.getData(key: 'token');
      id = CacheHelper.getData(key: 'id');
      role = CacheHelper.getData(key: 'role');
       if (token != null) {
        widget= const HomeScreen();
       //   widget= const AddJewelleries();
        } else {
          widget = const LoginScreen();
        }
      navigateAndFinish(context, widget);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/ZUREA.png',
                fit: BoxFit.cover,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
