import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/widgets/custom_form_field.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/features/home/view/grid_item.dart';
import 'package:fashion/features/search/cubit/cubit.dart';
import 'package:fashion/features/search/cubit/states.dart';
import 'package:fashion/features/search/veiw/GridItemSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/show_toast.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static TextEditingController searchController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SearchCubit()..getSearchProduct(searchText: 'Test'),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){
          if(state is SearchProductsErrorState){
            showToast(
              text: state.error,
              color: Colors.red,
            );
          }
        },
        builder: (context,state) {
          SearchCubit cubit = SearchCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap:(){
                              navigateBack(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        const SizedBox(width: 4,),
                        Expanded(
                          child: CustomFormField(
                            prefixIcon: Image.asset('assets/images/search.png'),
                            textStyleHint: Theme.of(context).textTheme.headline1,
                            circleDecouration: 20,
                            onTapp: (value){
                              if(searchController.text.isEmpty){
                                cubit.getSearchProduct(searchText: 'Test');
                              }
                              cubit.getSearchProduct(searchText: value);
                            },
                            textInputType: TextInputType.text,
                            validationPassed: isValidationPassed,
                            controller: searchController,
                            validate: (String? value) {
                              if (value!.isEmpty ) {
                                isValidationPassed = true;
                                return 'please enter your password';
                              }
                            },
                            hintText: 'Search',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ConditionalBuilder(
                              condition: cubit.getSearchProducts != null,
                              builder: (context) {
                                return ConditionalBuilder(
                                    condition: cubit.getSearchProducts!.data.isNotEmpty,
                                    builder: (context) {
                                    return GridItemSearch(cubit: cubit,);
                                  },
                                  fallback: (context){
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*0.4,
                                          ),
                                          const Text('There are no products to display'),
                                        ],
                                      );
                                  },
                                );
                              },
                              fallback: (context)=> const GridItemSearchLoading(),
                            ),
                            const SizedBox(height: 6,),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
