import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/core/alerts/app.top.snackbar.dart';
import 'package:uae_meditation_center/core/constans/app.constans.dart';
import 'package:uae_meditation_center/data/models/user.model.dart';
import 'package:uae_meditation_center/presentation/components/user.card.dart';
import 'package:uae_meditation_center/core/alerts/loading.popup.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:uae_meditation_center/presentation/screens/auth/services/auth.services.dart';
import 'package:uae_meditation_center/providers/user.provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitch = false;

  logOut() {
    LoadingPopup.show('Logging out...');
    AuthServices.logOut();
    context.pushReplacement('/login');
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
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
          'Settings',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Consumer(
                      builder: (
                        BuildContext context,
                        UserProvider userProvider,
                        child,
                      ) =>
                          FutureBuilder(
                        // get user
                        future: userProvider.getUserById(
                          FirebaseAuth.instance.currentUser!.uid,
                        ),
                        builder: (context, snapshot) {
                          // error getting user
                          if (snapshot.hasError) {
                            EasyLoading.dismiss();
                            AppTopSnackbar.showTopSnackBar(
                                context, "Something went wrong");

                            context.push('/main');
                          }
                          // loading user data
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            LoadingPopup.show('Logging...');
                          }
                          // has user data
                          if (snapshot.hasData) {
                            EasyLoading.dismiss();
                            final user = snapshot.data as UserModel;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                UserCard(
                                  imageUrl: user.profileImage,
                                  isEdit: false,
                                  selectImage: (){},
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  user.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                                Text(
                                  user.email,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor,
                                      ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05),
                                _items(
                                  Icons.help,
                                  "Help & Support",
                                  "Get assistance",
                                  () {
                                    context.push('/help_and_support');
                                  },
                                ),
                                _items(
                                  Icons.settings,
                                  "Account settings",
                                  "Manage your account",
                                  () {
                                    context.push('/account_settings');
                                  },
                                ),
                                _items(
                                  Icons.animation,
                                  "Animation",
                                  "Change duration",
                                  
                                  () {
                                     context.push('/animation_settings');
                                  },
                                ),
                                _items(
                                  Icons.logout,
                                  "Logout",
                                  "Sign out of your account",
                                  () {
                                    logOut();
                                  },
                                ),

                                 
                                Spacer(),

                               
                                Text(
                                  AppData.appVersion,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _items(
    IconData icon,
    String text,
    String subText,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.whiteColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          icon,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          subText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.whiteColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
