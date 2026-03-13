import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils/theme.dart';

class LogInScreen extends StatelessWidget {
  static const routeURL = "/login";
  static const routeName = "login";

  const LogInScreen({super.key});

  void _onSignupTap(BuildContext context) {
    context.pop();
  }

  void _onAuthButtonTap(BuildContext context, String location) {
    context.push(location);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => screen,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Create a profile, follow other accounts, make your own videos, and more.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
              Gaps.v40,
              AuthButton(
                text: "Use email & password",
                icon: const FaIcon(FontAwesomeIcons.user),
                onTap: () =>
                    _onAuthButtonTap(context, LoginFormScreen.routeName),
              ),
              Gaps.v20,
              AuthButton(
                text: "Use Github",
                icon: const FaIcon(FontAwesomeIcons.github),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            Gaps.h5,
            GestureDetector(
              onTap: () => _onSignupTap(context),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
