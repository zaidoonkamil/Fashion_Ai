import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/widgets/circular_progress.dart';
import 'package:fashion/core/widgets/custom_button.dart';
import 'package:fashion/core/widgets/custom_form_field.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/core/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController CpasswordController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
          listener: (context,state){
            if(state is AppRegisterErrorState){
              showToast(text: state.error, color: Colors.redAccent);
            }
            if(state is AppRegisterSuccessState){
              navigateBack(context);
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
                            height: 120,
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
                          const SizedBox(height: 80,),
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
                            controller: emailController,
                            validationPassed: isValidationPassed,
                            validate: (String? value) {
                              if (value!.isEmpty ) {
                                isValidationPassed = true;
                                cubit.validation();
                                return 'please enter your email';
                              }
                            },
                            hintText: 'Email',
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
                            height: 22,
                          ),
                          CustomFormField(
                            colorBorderContent: Colors.white,
                            controller: CpasswordController,
                            validationPassed: isValidationPassed,
                            validate: (String? value) {
                              if (value!.isEmpty ) {
                                isValidationPassed = true;
                                cubit.validation();
                                return 'please Confirm your password';
                              }
                            },
                            hintText: 'Confirm Password',
                          ),
                          const SizedBox(
                            height: 68,
                          ),
                          ConditionalBuilder(
                            condition: state is! AppRegisterLoadingState,
                            builder: (context)=> CustomBottom(
                              width: 150,
                              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                              borderRadius: BorderRadius.circular(6),
                              text: 'Sign Up',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.signUp(
                                      name: userNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      Cpassword: CpasswordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context)=> const Center(child: CircularProgress(),),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          GestureDetector(
                            onTap: (){
                              navigateBack(context);
                            },
                            child: Text(
                              'i have an accunt',
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
