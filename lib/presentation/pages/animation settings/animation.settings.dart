import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:uae_meditation_center/data/services/animation.services.dart';
import 'package:uae_meditation_center/presentation/components/introduction.text.dart';

class AnimationSettings extends StatefulWidget {
  const AnimationSettings({super.key});

  @override
  State<AnimationSettings> createState() => _AnimationSettingsState();
}

class _AnimationSettingsState extends State<AnimationSettings> {
  int durationVal = 1;

Future<void> getDuration() async {
  final val = await AnimationServices().getAnimationDuration();
  setState(() {
    durationVal = val;
  });
}



@override
  void initState() {
    getDuration();
    super.initState();
  }

  void incrementVal() {
    if (durationVal != 10) {
      durationVal++;
      saveDuration(durationVal);
      setState(() {});
    }
  }

  void decrementVal() {
    if (durationVal != 0) {
      durationVal--;
      saveDuration(durationVal);
      setState(() {});
    }
  }

  void saveDuration(durationVal) async{
    await AnimationServices().setAnimationDuration(durationVal);
  }


   

  @override
  Widget build(BuildContext context) {
    // theme
    final theme = Theme.of(context);
    // height
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.whiteColor,
            size: 20,
          ),
        ),
        title: Text(
          'Animation Settings',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Change animation duration between page transitions",
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: AppColors.whiteColor),
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Seconds",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            decrementVal();
                          },
                          icon: Icon(
                            Icons.arrow_left,
                            size: 30,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          durationVal.toString().split(".")[0],
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        IconButton(
                          onPressed: () {
                            incrementVal();
                          },
                          icon: Icon(
                            Icons.arrow_right,
                            size: 30,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            IntroductionText.text(
              theme,
              "Animation duration must be a value between 1 and 10",
            ),
            IntroductionText.text(
              theme,
              "Use the arrow keys to change the value.",
            ),
            IntroductionText.text(
              theme,
              "Refresh the app to enjoy the new animation experience.",
            ),
            const Spacer(),
            Center(
              child: Image.asset(
                "assets/logo/header-text.png",
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
