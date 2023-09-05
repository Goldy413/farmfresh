import 'package:farmfresh/module/category_module/category_home_module/category/category_bloc.dart';
import 'package:farmfresh/module/category_module/category_home_module/category_repository.dart';
import 'package:farmfresh/routes.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CategoryRepository(),
      child: BlocProvider(
        create: (context) => CategoryBloc(context.read())..add(GetCategory()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            var bloc = context.read<CategoryBloc>();
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Category"),
                  actions: [
                    InkWell(
                      onTap: () {
                        bloc.add(GridSelectedEvent(true));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ImageConstants.icongrid,
                            width: 20,
                            height: 20,
                            color: bloc.gridSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.grey,
                          ),
                          bloc.gridSelected
                              ? Text(
                                  "Grid",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: bloc.gridSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                          : Colors.grey),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        bloc.add(GridSelectedEvent(false));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ImageConstants.iconlists,
                            width: 20,
                            height: 20,
                            color: bloc.gridSelected
                                ? Colors.grey
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                          bloc.gridSelected
                              ? const SizedBox()
                              : Text(
                                  "List",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: bloc.gridSelected
                                          ? Colors.grey
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.all(5),
                  child: bloc.categoryItem.isNotEmpty
                      ? bloc.gridSelected
                          ? GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0,
                                      mainAxisExtent: 230),
                              itemCount: bloc.categoryItem.length,
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () => context.push(
                                      AppPaths.categoryDetail,
                                      extra: bloc.categoryItem[index]),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 2,
                                            color: Colors.grey,
                                          )
                                        ]),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            bloc.categoryItem[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Text(
                                              bloc.categoryItem[index]
                                                  .categoryName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                        ),
                                        Text(
                                          bloc.categoryItem[index].desc,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  )))
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: bloc.categoryItem.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 5,
                                  ),
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () => context.push(
                                        AppPaths.categoryDetail,
                                        extra: bloc.categoryItem[index]),
                                    child: Container(
                                      width: 1.sw,
                                      height: 150,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                              color: Colors.grey,
                                            )
                                          ]),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            bloc.categoryItem[index].image,
                                            width: 1.sw,
                                            fit: BoxFit.cover,
                                          ),
                                          const Positioned.fill(
                                              child: ColoredBox(
                                                  color: Colors.black12)),
                                          Positioned.fill(
                                              child: Center(
                                            child: Text(
                                              bloc.categoryItem[index]
                                                  .categoryName
                                                  .toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ))
                      : Center(
                          child: Text(
                            "Don't have any Category.\nPlease click (+) icon to add new Category.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                ));
          },
        ),
      ),
    );
  }
}
