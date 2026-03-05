import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(
      context,
    ).push(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  void _onAuthButtonTap(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TikTok",
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
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: "Use email & password",
                      icon: const FaIcon(FontAwesomeIcons.user),
                      onTap: () => _onAuthButtonTap(
                        context,
                        const UserNameScreen(),
                      ),
                    ),
                    Gaps.v20,
                    AuthButton(
                      text: "Use Github",
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onTap: () {},
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: "Use email & password",
                            icon: const FaIcon(FontAwesomeIcons.user),
                            onTap: () => _onAuthButtonTap(
                              context,
                              const UserNameScreen(),
                            ),
                          ),
                        ),
                        Gaps.h20,
                        Expanded(
                          child: AuthButton(
                            text: "Use Github",
                            icon: const FaIcon(FontAwesomeIcons.github),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    "Log In",
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
      },
    );
  }
}
