import 'package:flutter/widgets.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
