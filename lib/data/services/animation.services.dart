import 'package:shared_preferences/shared_preferences.dart';

class AnimationServices {
  
  // add animation duration
Future<void > setAnimationDuration(int duration) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('animationDuration', duration);
}

// get animation duration
  Future<int> getAnimationDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('animationDuration') ?? 1;
  }


}