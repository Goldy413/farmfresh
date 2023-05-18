import 'package:farmfresh/module/login_module/login_view.dart';
import 'package:farmfresh/module/splash_module/splash_view.dart';
import 'package:farmfresh/module/tabber_module/tabber_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
initialLocation: AppPaths.initial,
routes: [
  GoRoute(
    path: AppPaths.initial,
    name: AppPaths.initial,
    builder: (context, state) => const SplashView(),
  ),
  GoRoute(
    path: AppPaths.tabbar,
    name: AppPaths.tabbar,
    builder: (context, state) => const TabberView(),
  ),
  GoRoute(
    path: AppPaths.login,
    name: AppPaths.login,
    builder: (context, state) => LoginView(),
  ),
]);

class AppPaths {
  static const initial = '/';
  static const login = '/login';
  static const tabbar = '/tabbar';
}
