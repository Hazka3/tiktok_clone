import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoPlay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
