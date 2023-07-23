import 'package:farmfresh/module/category_module/category_detal_module/categoryDetail/category_detail_bloc.dart';
import 'package:farmfresh/module/category_module/category_detal_module/category_detail_repository.dart';
import 'package:farmfresh/module/category_module/category_home_module/model/category.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryDetailView extends StatelessWidget {
  final CategoryItem category;
  const CategoryDetailView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RepositoryProvider(
          create: (context) => CategoryDetailRepository(),
          child: BlocProvider(
            create: (context) => CategoryDetailBloc(category, context.read())
              ..add(GetSubCategory())
              ..add(GetCategoryProduct()),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 80,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(22),
                    child: Container(
                      width: 1.sw,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.sp),
                              topRight: Radius.circular(25.sp))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.categoryName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  expandedHeight: 300.0,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      category.image,
                      width: 1.sw,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
                    builder: (context, state) {
                      var bloc = context.read<CategoryDetailBloc>();
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text(category.desc),
                            const SizedBox(
                              height: 6,
                            ),
                            bloc.subCategoryItem.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sub-Category",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemCount:
                                              bloc.subCategoryItem.length,
                                          itemBuilder: (context, subcatIndex) =>
                                              Card(
                                            color: Colors.white,
                                            child: ExpansionTile(
                                              backgroundColor: Colors.white,
                                              shape: Border.all(
                                                  color: Colors.transparent),
                                              leading: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Image.network(bloc
                                                    .subCategoryItem[
                                                        subcatIndex]
                                                    .image),
                                              ),
                                              tilePadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              title: Text(
                                                bloc
                                                    .subCategoryItem[
                                                        subcatIndex]
                                                    .subCategoryName,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                bloc
                                                    .subCategoryItem[
                                                        subcatIndex]
                                                    .desc,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              childrenPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              onExpansionChanged: (value) => {
                                                if (value &&
                                                    bloc
                                                        .subCategoryItem[
                                                            subcatIndex]
                                                        .productItem
                                                        .isEmpty)
                                                  {
                                                    bloc.add(
                                                        GetSubCategoryProduct(
                                                            subcatIndex))
                                                  }
                                              },
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5.0,
                                                            vertical: 0.0),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        shrinkWrap: true,
                                                        itemCount: bloc
                                                            .subCategoryItem[
                                                                subcatIndex]
                                                            .productItem
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                InkWell(
                                                                  onTap: () => {
                                                                    context.push(
                                                                        AppPaths
                                                                            .product,
                                                                        extra: bloc
                                                                            .subCategoryItem[subcatIndex]
                                                                            .productItem[index])
                                                                  },
                                                                  child: Card(
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(4.0),
                                                                            child:
                                                                                Image.network(
                                                                              bloc.subCategoryItem[subcatIndex].productItem[index].image,
                                                                              width: 50,
                                                                              height: 50,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Expanded(
                                                                              child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                bloc.subCategoryItem[subcatIndex].productItem[index].name,
                                                                                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Text(
                                                                                bloc.subCategoryItem[subcatIndex].productItem[index].desc,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          )),
                                                                          bloc.subCategoryItem[subcatIndex]
                                                                              .productItem[index]
                                                                              .getPrice(),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          )
                                                                        ],
                                                                      )),
                                                                )))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            bloc.independentProductItem.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Products",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.0),
                                          child: GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: const EdgeInsets.all(0),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5.0,
                                                mainAxisSpacing: 5.0,
                                              ),
                                              itemCount: bloc
                                                  .independentProductItem
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                    onTap: () => {
                                                      context.push(
                                                          AppPaths.product,
                                                          extra:
                                                              bloc.independentProductItem[
                                                                  index])
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              offset:
                                                                  Offset(1, 1),
                                                              blurRadius: 2,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ]),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                Image.network(
                                                              bloc
                                                                  .independentProductItem[
                                                                      index]
                                                                  .image,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    bloc
                                                                        .independentProductItem[
                                                                            index]
                                                                        .name,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleMedium
                                                                        ?.copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                bloc.independentProductItem[
                                                                        index]
                                                                    .getPrice()
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            bloc
                                                                .independentProductItem[
                                                                    index]
                                                                .desc,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )))
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
