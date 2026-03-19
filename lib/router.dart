import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/signup_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
