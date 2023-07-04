import 'package:farmfresh/module/tabber_module/tabber/tabber_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabberView extends StatelessWidget {
  const TabberView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabberBloc(),
      child: BlocBuilder<TabberBloc, TabberState>(
        builder: (context, state) {
          final bloc = context.read<TabberBloc>()..add(SubscribeBrodcast());
          return Scaffold(
              bottomNavigationBar: Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SafeArea(
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutQuint,
                          child: Row(
                            children: List.generate(
                                bloc.tabs.length,
                                (index) => Expanded(
                                        child: RawMaterialButton(
                                      onPressed: () =>
                                          bloc.add(ChangeTabEvent(index)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                              bloc.tabs[index].icon,
                                              colorFilter: ColorFilter.mode(
                                                  bloc.selectedIndex == index
                                                      ? const Color(0XFF07602E)
                                                      : const Color(0XFF85BD9F),
                                                  BlendMode.srcIn),
                                              fit: BoxFit.fitHeight,
                                              height:
                                                  bloc.selectedIndex == index
                                                      ? 24.w
                                                      : 20.w,
                                              width: bloc.selectedIndex == index
                                                  ? 24.w
                                                  : 20.w),
                                          if (bloc.selectedIndex == index)
                                            Text(
                                              bloc.tabs[index].name,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          // tabController.selectedTab.value == index
                                                          //     ?
                                                          FontWeight.bold,
                                                      // : FontWeight.normal,
                                                      color:
                                                          bloc.selectedIndex ==
                                                                  index
                                                              ? const Color(
                                                                  0XFF07602E)
                                                              : const Color(
                                                                  0XFF85BD9F)),
                                            ),
                                          if (bloc.selectedIndex == index)
                                            Container(
                                                width: 25.w,
                                                height: 3.sp,
                                                color: const Color(0XFF07602E))
                                        ],
                                      ),
                                    ))),
                          )))),
              body: Center(
                child: bloc.tabs[bloc.selectedIndex].child,
              ));
        },
      ),
    );
  }
}
