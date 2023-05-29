import 'package:farmfresh/module/login_module/login_view.dart';
import 'package:farmfresh/module/on_bording_module/onboarding_view.dart';
import 'package:farmfresh/module/profile_module/profile_view.dart';
import 'package:farmfresh/module/splash_module/splash_view.dart';
import 'package:farmfresh/module/tabber_module/tabber_view.dart';
import 'package:farmfresh/module/verification_module/verification_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: AppPaths.initial, routes: [
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
  GoRoute(
    path: AppPaths.onbording,
    name: AppPaths.onbording,
    builder: (context, state) => const OnBoardingView(),
  ),
  GoRoute(
    path: "${AppPaths.passVerification}/:phone/:verifyId",
    name: AppPaths.passVerification,
    builder: (context, state) => VerificationView(
      phone: state.params['phone'] ?? "",
      verifyId: state.params['verifyId'] ?? "",
    ),
  ),
  GoRoute(
    path: "${AppPaths.profile}/:phone/:id",
    name: AppPaths.profile,
    builder: (context, state) => ProfileView(
      phone: state.params['phone'] ?? "",
      id: state.params['id'] ?? "",
    ),
  ),
]);

class AppPaths {
  static const initial = '/';
  static const login = '/login';
  static const tabbar = '/tabbar';
  static const onbording = '/onbording';
  static const passVerification = '/passVerification';
  static const profile = '/profile';
}
