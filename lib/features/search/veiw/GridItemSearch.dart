import 'package:fashion/features/details/veiw/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/widgets/constant.dart';
import '../cubit/cubit.dart';

class GridItemSearch extends StatelessWidget {
  const GridItemSearch({super.key, this.cubit});

  final SearchCubit? cubit;

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
            itemCount: cubit!.getSearchProducts!.data.length,
            itemBuilder: (BuildContext context, index) {
              String image= cubit!.getSearchProducts!.data[index].imageCover.replaceAll("localhost", ip);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen(id: cubit!.getSearchProducts!.data[index].id,)));
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

class GridItemSearchLoading extends StatelessWidget {
  const GridItemSearchLoading({super.key,});

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
            itemCount: 20,
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(6),
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

