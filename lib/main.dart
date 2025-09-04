import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uae_meditation_center/data/firebase/firebase_options.dart';
import 'package:uae_meditation_center/core/routing/app.routing.dart';
import 'package:uae_meditation_center/core/theme/app.theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:uae_meditation_center/data/services/animation.services.dart';
import 'package:uae_meditation_center/providers/user.provider.dart';
import 'package:provider/provider.dart';

 var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://471975712971444:HKHhCHpS3mPOXPfEK2Ag0W-9ygE@dwwhwh1s4'
  );
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

 cloudinary.config.urlConfig.secure = true;
 
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int durationVal = 1;
  Future<int> getDuration() async {
    final val = await AnimationServices().getAnimationDuration();
    setState(() {
      durationVal = val;
    });
    return val;
  }

  @override
  void initState() {
    super.initState();
    getDuration();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mediation Center',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouting(duration: durationVal).appRouter,
      builder: EasyLoading.init(),
    );
  }
}
