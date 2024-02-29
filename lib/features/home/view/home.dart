import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fashion/core/widgets/circular_progress.dart';
import 'package:fashion/core/widgets/constant.dart';
import 'package:fashion/core/widgets/custom_button.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/core/widgets/show_toast.dart';
import 'package:fashion/features/details/veiw/details.dart';
import 'package:fashion/features/home/cubit/cubit.dart';
import 'package:fashion/features/home/cubit/states.dart';
import 'package:fashion/features/home/view/grid_item.dart';
import 'package:fashion/features/search/veiw/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer_v/flutter_slider_drawer_v.dart';

import '../../../core/styles/colors.dart';
import '../../profile/veiw/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final GlobalKey<SliderMenuContainerState> _key = GlobalKey<SliderMenuContainerState>();
  static TextEditingController searchController = TextEditingController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  bool showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (showFab) {
          setState(() {
            showFab = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!showFab) {
          setState(() {
            showFab = true;
          });
        }
      }
    });
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      showFab=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          if(role =='user'){
            return HomeCubit()..getHomeUserProducts(page: '1')..getUserOrder()..getDataProfile();
          }else{
            return HomeCubit()..getHomeUserProducts(page: '1')..getDataProfile();
          }
        },
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if(state is HomeProductsErrorState){
            showToast(
                text: state.error,
                color: Colors.red,
            );
          }
          if(state is DeleteUserOrderSuccessState){
            showToast(
                text: 'delete Products success',
                color: Colors.green,
            );
          }
          if(state is DeleteUserOrderErrorState){
            showToast(
                text: state.error,
                color: Colors.green,
            );
          }
        },
        builder: (context,state){
          HomeCubit cubit= HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
              floatingActionButton:showFab? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: FloatingActionButton(
                      onPressed: () {
                        scrollToTop();
                      },
                      backgroundColor: primaryColor,
                      child: Center(child: Image.asset('assets/images/floating_icon.png',),),
                    ),
                  ),
                ),
              ):Container(),
              body: ConditionalBuilder(
                condition:role =='user'?
                cubit.getOrder != null && cubit.profileModell != null: true && cubit.getHomeProducts != null,
                builder: (context) {
                  String image= cubit.profileModell!.data.photo.replaceAll("localhost", ip);
                  return role =='user'? SliderMenuContainer(
                    key: HomeScreen._key,
                    hasAppBar: false,
                    slideDirection: SlideDirection.RIGHT_TO_LEFT,
                    sliderMenuOpenSize: 309,
                    sliderMenu: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          Image.asset(
                            'assets/images/ZUREA (1).png',
                            height: 20,
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      image,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(cubit.profileModell!.data.name),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  signOut(context);
                                  },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Image.asset(
                                    'assets/images/Sign in Square (1).png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'All order : ',
                                    style: Theme.of(context).textTheme.headline1,
                                  ),
                                  Text(
                                    role =='user'?  cubit.getOrder!.totalPrice.toString():'',
                                    style: Theme.of(context).textTheme.headline1,
                                  ),
                                ],
                              ),
                              CustomBottom(
                                borderRadius: BorderRadius.circular(6),
                                height: 30,
                                text: 'Buy Order',
                                colorBottom: const Color(0xC7FFE493),
                                colorBorderBottom: const Color(0xC7FFE493),
                                icon: Image.asset(
                                  'assets/images/sala.png',
                                  height: 20,
                                ),
                                textStyle:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                  color: const Color(0xFFF7A01F),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                              width: double.maxFinite,
                              height: 4,
                              color: Theme.of(context).dividerColor),
                          const SizedBox(
                            height: 30,
                          ),
                          role =='user'? Expanded(
                            child: ListView.builder(
                                itemCount: cubit.getOrder!.length,
                                itemBuilder: (context, index) {
                                  String image= cubit.getOrder!.data[index].product.imageCover.replaceAll("localhost", ip);
                                  String  hexColor =cubit.getOrder!.data[index].color;
                                  Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 110,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              image,
                                              width: 100,
                                              height: 110,
                                              fit: BoxFit.fill,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cubit.getOrder!.data[index].product.name.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '\$',
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                .primaryColor),
                                                      ),
                                                      Text(cubit.getOrder!.data[index].product.price.toString(),),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    60),
                                                                color: Theme.of(context)
                                                                    .backgroundColor),
                                                            child: Center(
                                                                child: Text(
                                                                    cubit.getOrder!.data[index].size.toString(),
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headline1!
                                                                      .copyWith(
                                                                      color:
                                                                      Colors.white),
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    60),
                                                                color: color),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          CustomBottom(
                                                              onTap: (){
                                                                if(cubit.getOrder!.data[index].paid == false){
                                                                  cubit.deleteUserOrder(id: cubit.getOrder!.data[index].id);
                                                                 cubit.getHomeUserProducts(page: '1');
                                                                  cubit.getUserOrder();
                                                                }
                                                              },
                                                              borderRadius: BorderRadius.circular(6),
                                                              height: 30,
                                                              text: cubit.getOrder!.data[index].paid == true?
                                                              'Is Paid':'Delete',
                                                              colorBottom: Theme.of(context).scaffoldBackgroundColor,
                                                              colorBorderBottom: Theme.of(context).scaffoldBackgroundColor,
                                                              icon: cubit.getOrder!.data[index].paid == true? Image.asset(
                                                                'assets/images/Vector (10).png',
                                                                height: 20,
                                                              ):Image.asset(
                                                                'assets/images/Trash can.png',
                                                                height: 20,
                                                              ),
                                                              textStyle: Theme.of(context).textTheme.headline1,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  );
                                }),
                          ):Container()
                        ],
                      ),
                    ),
                    sliderMain: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        return true;
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 12),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              'assets/images/ZUREA (1).png',
                                              height: 20,
                                              width: 60,
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                navigateTo(context,  const SearchScreen());
                                              },
                                              child: Container(
                                                height: 28,
                                                width: 82,
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      offset: const Offset(0, 2),
                                                      blurRadius: 4,
                                                      spreadRadius: 0,
                                                    ),
                                                  ],
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width: 20,height: 2,color: lightHintIconsColor,),
                                                    ),
                                                    const SizedBox(width: 2,),
                                                    Image.asset(
                                                      'assets/images/search.png',
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                role =='user'? GestureDetector(
                                                    onTap: () {
                                                      HomeScreen._key.currentState!.openDrawer();

                                                    },
                                                    child: Image.asset(
                                                      'assets/images/Vector (8).png',
                                                      height: 20,
                                                    )):Container(),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              role =='shop'?  GestureDetector(
                                                    onTap: () {
                                                      navigateTo(context, const Profile());
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/profile.png',
                                                      height: 20,
                                                    )):Container(),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ConditionalBuilder(
                                    condition: cubit.getHomeProducts != null,
                                    builder: (context) {
                                      return GridItemHome(cubit: cubit,);
                                    },
                                    fallback: (context)=> const GridItemHomeLoading(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/ZUREA (1).png',
                                          height: 20,
                                          width: 60,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            navigateTo(context,  const SearchScreen());
                                          },
                                          child: Container(
                                            height: 28,
                                            width: 82,
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 20,height: 2,color: lightHintIconsColor,),
                                                ),
                                                const SizedBox(width: 2,),
                                                Image.asset(
                                                  'assets/images/search.png',
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            role =='user'? GestureDetector(
                                                onTap: () {
                                                  HomeScreen._key.currentState!.openDrawer();

                                                },
                                                child: Image.asset(
                                                  'assets/images/Vector (8).png',
                                                  height: 20,
                                                )):Container(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            role =='shop'?  GestureDetector(
                                                onTap: () {
                                                  navigateTo(context, const Profile());
                                                },
                                                child: Image.asset(
                                                  'assets/images/profile.png',
                                                  height: 20,
                                                )):Container(),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ConditionalBuilder(
                                condition: cubit.getHomeProducts != null,
                                builder: (context) {
                                  return GridItemHome(cubit: cubit,);
                                },
                                fallback: (context)=> const GridItemHomeLoading(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context)=> const Center(child: CircularProgress()),
              ),
            ),
          );
        },
      ),
    );
  }
}
