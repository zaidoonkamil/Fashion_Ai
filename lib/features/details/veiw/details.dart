import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/styles/colors.dart';
import 'package:fashion/core/widgets/circular_progress.dart';
import 'package:fashion/core/widgets/constant.dart';
import 'package:fashion/core/widgets/custom_button.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/features/details/cubit/cubit.dart';
import 'package:fashion/features/details/cubit/states.dart';
import 'package:fashion/features/home/view/grid_item.dart';
import 'package:fashion/features/ss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/local_save_storege/cache_helper.dart';
import '../../../core/widgets/show_toast.dart';
import '../../home/view/home.dart';
import 'grid_item.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key,required this.id});

  final String id;
  static CarouselController carouselController = CarouselController();
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=> DetailsCubit()..getDetailsProducts(page: id),
      child: BlocConsumer<DetailsCubit,DetailsStates>(
        listener: (context,state){
          if(state is AddToCartErrorState){
            showToast(
              text: state.error,
              color: Colors.red,
            );
          }
          if(state is AddToCartSuccessState){
            showToast(
              text: 'تمت الاضافة الى السلة',
              color: Colors.green,
            );
            navigateAndFinish(context, const HomeScreen());
          }
          if(state is DetailsProductsSuccessState){
            DetailsCubit.get(context).getClassProducts(
                page: DetailsCubit.get(context).detailsProducts!.data.dataClass);
          }
        },
        builder: (context,state){
          DetailsCubit cubit=DetailsCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: ConditionalBuilder(
                condition: cubit.detailsProducts != null,
                builder: (context) {
                  List<String> originalImages = cubit.detailsProducts!.data.images;
                  List<String> updatedImages = originalImages.map((url) => url.replaceAll("localhost", ip)).toList();
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                              items: updatedImages.map(
                                    (item) => Image.network(
                                      item,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ).toList(),
                              options: CarouselOptions(
                                  height: MediaQuery.of(context).size.height*0.49,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: true,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 6),
                                  autoPlayAnimationDuration: const Duration(seconds: 1),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, r) {
                                    currentIndex = index;
                                    cubit.validation();
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          cubit.detailsProducts!.data.user.photo.replaceAll("localhost", ip),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(cubit.detailsProducts!.data.user.name,style: const TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        navigateBack(context);
                                      },
                                      child: const Icon(Icons.arrow_back,color: Colors.white,)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.48,
                              width: double.maxFinite,
                              child:Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: cubit.detailsProducts!.data.images.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          carouselController.animateToPage(entry.key),
                                      child: Container(
                                        width: currentIndex == entry.key ? 8 : 8,
                                        height: 7.0,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: currentIndex == entry.key
                                                ? Colors.grey
                                                : Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(cubit.detailsProducts!.data.dataClass,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),),
                                            Row(
                                              children: [
                                                Text(cubit.detailsProducts!.data.ratingsAverage.toString(),style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),),
                                                const SizedBox(width: 4,),
                                                Image.asset('assets/images/star.png',width: 24,height: 24,),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(cubit.detailsProducts!.data.name,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 26)),
                                          ],
                                        ),
                                        const SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text('Color',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16),),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          height: 35,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: false,
                                              physics: const BouncingScrollPhysics(),
                                              itemCount: cubit.detailsProducts!.data.colors.length,
                                              itemBuilder:(context,index){
                                                String  hexColor =cubit.detailsProducts!.data.colors[index];
                                                Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
                                                return Column(
                                                  children: [
                                                    Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding: const EdgeInsets.all(6),
                                                      margin: const EdgeInsets.only(right: 4),
                                                      decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius: BorderRadius.circular(70),
                                                        // border: Border.all(color: Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        const SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Text('Size',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16),),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          height: 35,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: false,
                                              physics: const BouncingScrollPhysics(),
                                              itemCount: cubit.detailsProducts!.data.sizes.length,
                                              itemBuilder:(context,index){
                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(6),
                                                      margin: const EdgeInsets.only(right: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(70),
                                                        border: Border.all(color: Colors.black),
                                                      ),
                                                      child: Text(cubit.detailsProducts!.data.sizes[index]..toString()),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        const SizedBox(height: 20,),
                                        const Row(
                                          children: [
                                            Text('Description',style: TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                        const SizedBox(height: 6,),
                                        Row(
                                          children: [
                                            Expanded(child:
                                            Text(cubit.detailsProducts!.data.description,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),),),
                                          ],
                                        ),
                                        const SizedBox(height: 30,),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Text('\$ ',style: TextStyle(color: primaryColor,fontSize: 18),),
                                                  Text(cubit.detailsProducts!.data.price.toString(),style: const TextStyle(fontSize: 18),),
                                                ],
                                              ),
                                            ),
                                           role=='user'? Expanded(
                                              flex: 2,
                                              child: CustomBottom(
                                                onTap: (){
                                                  cubit.addToCart(
                                                      productId: id,
                                                      shopId: cubit.detailsProducts!.data.userId,
                                                      size: cubit.detailsProducts!.data.sizes[0],
                                                      color: cubit.detailsProducts!.data.colors[0],
                                                  );
                                                  },
                                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                text: 'ADD TO CARD',
                                              ),
                                            ):Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ConditionalBuilder(
                                    condition: cubit.getClassProductsModel != null,
                                    builder: (context) {
                                      return GridItemDetails(cubit: cubit,);
                                    },
                                    fallback: (context)=> const Center(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 40,),
                                          CircularProgressIndicator()
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  );
                },
                fallback: (context)=>const Center( child: CircularProgress()),
              ),
            ),
          );
        },
      ),
    );
  }
}
