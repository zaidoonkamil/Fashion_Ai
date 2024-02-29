import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/local_save_storege/cache_helper.dart';
import 'package:fashion/core/widgets/circular_progress.dart';
import 'package:fashion/core/widgets/custom_button.dart';
import 'package:fashion/core/widgets/custom_form_field.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/features/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/constant.dart';
import '../../../core/widgets/show_toast.dart';
import '../../home/view/home.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context,state){
          if(state is AppLoginSuccessState){
            CacheHelper.saveData(key: 'token',value: AppLoginCubit.get(context).token);
            CacheHelper.saveData(key: 'role',value: AppLoginCubit.get(context).role);
            CacheHelper.saveData(key: 'id',value: AppLoginCubit.get(context).id);
            id = CacheHelper.getData(key: 'id');
            role = CacheHelper.getData(key: 'role');
            token = CacheHelper.getData(key: 'token');
            navigateAndFinish(context, const HomeScreen());
          }
          if(state is AppLoginErrorState){
            showToast(text: state.error, color: Colors.redAccent);
          }
        },
        builder: (context,state) {
          var cubit= AppLoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 160,
                        ),
                        Image.asset(
                          'assets/images/ZUREA.png',
                          fit: BoxFit.cover,
                          height: 35,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welocme ...',
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 62,
                        ),
                        CustomFormField(
                          colorBorderContent: Colors.white,
                          controller: userNameController,
                          validationPassed: isValidationPassed,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              isValidationPassed = true;
                              cubit.validation();
                              return 'please enter your name';
                            }
                          },
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        CustomFormField(
                          colorBorderContent: Colors.white,
                          controller: passwordController,
                          validationPassed: isValidationPassed,
                          validate: (String? value) {
                            if (value!.isEmpty ) {
                              isValidationPassed = true;
                              cubit.validation();
                              return 'please enter your password';
                            }
                          },
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo(context, const CheckEmail());
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(' Forget password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14)),
                                Text(' ? ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14)),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 68,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context)=> CustomBottom(
                            width: 150,
                            textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                            borderRadius: BorderRadius.circular(6),
                            text: 'LOG IN',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.signIn(
                                  email: userNameController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                          fallback: (context)=> const Center(child: CircularProgress(),),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        GestureDetector(
                          onTap: (){
                            navigateTo(context, const Register());
                          },
                          child: Text(
                            'not have an accunt',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );

  }
}
