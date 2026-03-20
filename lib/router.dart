import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/main_navigation/main_navigation.screen.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/signup_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

final router = GoRouter(
  initialLocation: SignUpScreen.routeURL,
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginFormScreen.routeName,
      path: LoginFormScreen.routeURL,
      builder: (context, state) => const LoginFormScreen(),
    ),
    GoRoute(
      name: LogInScreen.routeName,
      path: LogInScreen.routeURL,
      builder: (context, state) => const LogInScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: MainNavigationScreen.routeURL,
      builder: (context, state) {
        final tab = state.pathParameters["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    // GoRoute(
    //   path: "/users/:username",
    //   builder: (context, state) {
    //     final username = state.pathParameters['username'];
    //     final tab = state.uri.queryParameters["show"];
    //     return UserProfileScreen(
    //       username: username!,
    //       tab: tab!,
    //     );
    //   },
    // ),
  ],
);
