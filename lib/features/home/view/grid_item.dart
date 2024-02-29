import 'package:fashion/features/details/veiw/details.dart';
import 'package:fashion/features/home/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/widgets/constant.dart';

class GridItemHome extends StatelessWidget {
  const GridItemHome({super.key, this.cubit});

  static ScrollController? scrollController;
  final HomeCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
            controller: scrollController,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: cubit!.getHomeProducts!.data.length,
            itemBuilder: (BuildContext context, index) {
              String image= cubit!.getHomeProducts!.data[index].imageCover.replaceAll("localhost", ip);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen(id: cubit!.getHomeProducts!.data[index].id,)));
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
            })
      ],
    );
  }
}

class GridItemHomeLoading extends StatelessWidget {
  const GridItemHomeLoading({super.key,});

  static ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
            controller: scrollController,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: 20,
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
              );
            },
            staggeredTileBuilder: (index) {
              return const StaggeredTile.count(1, 1.4);
            })
      ],
    );
  }
}

