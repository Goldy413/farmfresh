import 'package:farmfresh/module/account_module/account_view.dart';
import 'package:farmfresh/module/bag_module/bag_view.dart';
import 'package:farmfresh/module/category_module/category_home_module/category_view.dart';
import 'package:farmfresh/module/home_module/home_view.dart';
import 'package:farmfresh/module/tabber_module/model/tabber_model.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tabber_event.dart';
part 'tabber_state.dart';

class TabberBloc extends Bloc<TabberEvent, TabberState> {
  int selectedIndex = 0;
  final List<TabberModel> tabs = [
    TabberModel("Home", ImageConstants.homeSVG, HomeView()),
    TabberModel("Category", ImageConstants.categorySVG, const CategoryView()),
    TabberModel("Bag", ImageConstants.cartSVG, const BagView()),
    TabberModel("Account", ImageConstants.profileSVG, const AccountView())
  ];

  TabberBloc() : super(TabberInitial()) {
    on<TabberEvent>((event, emit) {});
    on<ChangeTabEvent>((event, emit) {
      selectedIndex = event.index;
      emit(ChangeTabState());
    });
  }
}
