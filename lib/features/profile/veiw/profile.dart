import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/styles/colors.dart';
import 'package:fashion/core/widgets/circular_progress.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/features/profile/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/constant.dart';
import '../cubit/cubit.dart';
import 'grid_item_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ProfileCubit()..getDataProfile()..getDataGridProfile()..getDataOrderAdmin(),
      child: BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context,state){},
        builder: (context,state ) {
          ProfileCubit cubit=ProfileCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: ConditionalBuilder(
                condition: cubit.profileModel != null && cubit.getProfileProducts != null && cubit.getOrderAdmin != null,
                builder: (context) {
                  String image= cubit.profileModel!.data.photo.replaceAll("localhost", ip);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Theme.of(context).primaryColor, Theme.of(context).scaffoldBackgroundColor],
                                  begin: const Alignment(- 1.1,- 1.1),
                                  end: const Alignment( - 0.4,0.7),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 24,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              navigateBack(context);
                                            },
                                            child: const Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            signOut(context);
                                          },
                                          child: Icon(Icons.output,
                                            color: primaryColor,),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipOval(
                                          child: Container(
                                            color: Theme.of(context).primaryColor,
                                            width: 110.0,
                                            height: 110.0,
                                          ),
                                        ),
                                        ClipOval(
                                          child: Container(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            width: 105.0,
                                            height: 105.0,
                                          ),
                                        ),
                                        ClipOval(
                                          child: Image.network(
                                            image,
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(cubit.profileModel!.data.name),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              cubit.profileModel!.data.email,
                                              style: Theme.of(context).textTheme.headline1,
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 40,),
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                cubit.changeButoom();
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset('assets/images/Icons.png'),
                                                      const SizedBox(width: 4,),
                                                      const Text('Orders'),
                                                    ],
                                                  ),
                                                  cubit.changeing==false? const Divider(height: 4,):const Divider(height: 4,color: Colors.black,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                cubit.changeButoom();
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset('assets/images/Vector (9).png'),
                                                      const SizedBox(width: 4,),
                                                      const Text('Post'),
                                                    ],
                                                  ),
                                                  cubit.changeing==true? const Divider(height: 4,):const Divider(height: 4,color: Colors.black,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            cubit.changeing==false?   Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GridItemProfile(cubit: cubit,),
                            ):Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GridItemProfileOrder(cubit: cubit,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context)=> const Center(child: CircularProgress()),
              ),
            ),
          );
        }
      ),
    );
  }
}
