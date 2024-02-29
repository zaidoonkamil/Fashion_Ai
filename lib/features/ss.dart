import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/features/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/widgets/circular_progress.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/navigation.dart';
import '../core/widgets/show_toast.dart';
import 'home/cubit/cubit.dart';
import 'home/cubit/states.dart';

class AddJewelleries extends StatelessWidget {
  const AddJewelleries({super.key});

  static var formKey = GlobalKey<FormState>();
  static List<String> carats = ['10','14','16','18','22','20','21','22','24'];
  static List<String> width = ['اونصة','5','10','20','25','30','50','100'];
  static TextEditingController nameController = TextEditingController();
  static TextEditingController quantityController = TextEditingController();
  static TextEditingController weightController = TextEditingController();
  static TextEditingController caratController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController typeNameController = TextEditingController();
  static TextEditingController typeIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if(state is SabikaAddJewelleriesSuccessStates){
            navigateAndFinish(context,  const HomeScreen());
          } else if (state is SabikaAddJewelleriesErrorStates) {
            print(state.error);
            showToast(
              text: state.error,
              color: Colors.red,
            );
          }
        },
        builder: (context,state){
          var cubit =HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        cubit.selectedImages != null?  GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: cubit.selectedImages!.length,
                          itemBuilder: (context, index) {
                            return Image.file(File(cubit.selectedImages![index].path));
                          },
                        ):
                        GestureDetector(
                          onTap: (){
                            cubit.pickImages();
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).iconTheme.color,
                            ),
                            child: Icon(
                              Icons.add_photo_alternate,
                              size: 60,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder:(context)=> CustomBottom(
                            width: double.maxFinite,
                            height: 65,
                            borderRadius: BorderRadius.circular(10),
                            colorBottom: Theme.of(context).primaryColor,
                            colorText: Colors.white,
                            text: 'اضافة المنتج',
                            onTap: () {
                                cubit.addJewelleries(
                                    files: cubit.selectedImages!,
                                    filesCover: cubit.selectedImages!,
                                );
                            },
                          ),
                          fallback: (context)=>const Center(child: CircularProgress()),
                        ),
                        const SizedBox(
                          height: 34,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
