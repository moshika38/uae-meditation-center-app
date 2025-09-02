import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uae_meditation_center/core/alerts/app.loading.dart';

class LoadingPopup {
  static Future show(String? text) {
    return EasyLoading.show(
      status: text ?? 'Logging...',
      indicator: AppLoading(),
      maskType: EasyLoadingMaskType.black,
    );
  }
}
