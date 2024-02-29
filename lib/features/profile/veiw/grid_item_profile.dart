import 'package:fashion/core/styles/colors.dart';
import 'package:fashion/core/widgets/navigation.dart';
import 'package:fashion/features/details/veiw/details.dart';
import 'package:fashion/features/home/cubit/cubit.dart';
import 'package:fashion/features/profile/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/widgets/constant.dart';

class GridItemProfile extends StatelessWidget {
  const GridItemProfile({super.key,required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: cubit.getProfileProducts!.data.length,
            itemBuilder: (BuildContext context, index) {
              String image= cubit.getProfileProducts!.data[index].imageCover.replaceAll("localhost", ip);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen(id: cubit.getProfileProducts!.data[index].id,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(6))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Image(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return const StaggeredTile.count(1, 1.4);
            },),
      ],
    );
  }
}

class GridItemProfileOrder extends StatelessWidget {
  const GridItemProfileOrder({super.key,required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cubit.getOrderAdmin!.data.length,
            itemBuilder: (BuildContext context, index) {
              String image= cubit.getOrderAdmin!.data[index].product.imageCover.replaceAll("localhost", ip);
              String  hexColor =cubit.getOrderAdmin!.data[index].color;
              Color color = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

              return Column(
                children: [
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      navigateTo(context, DetailsScreen(id: cubit.getOrderAdmin!.data[index].product.id,));
                    },
                    child: Container(
                      decoration: const BoxDecoration(

                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 170,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only( topLeft: Radius.circular(6),bottomLeft: Radius.circular(6),),
                                  child: Image(
                                    image: NetworkImage(
                                      image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(cubit.getOrderAdmin!.data[index].product.name,style: const TextStyle(fontSize: 18),),
                                          Row(
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
                                              Container(
                                                padding: const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(70),
                                                  border: Border.all(color: Colors.black),
                                                ),
                                                child: Text(cubit.getOrderAdmin!.data[index].size.toString()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(cubit.getOrderAdmin!.data[index].user.name,style: const TextStyle(fontSize: 16),),
                                          Row(
                                            children: [
                                              Text('\$ ',style: TextStyle(color: primaryColor),),
                                              Text(cubit.getOrderAdmin!.data[index].product.price.toString(),style: const TextStyle(fontSize: 16),),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(cubit.getOrderAdmin!.data[index].product.user.email),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
           ),

      ],
    );
  }
}
