import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uae_meditation_center/core/alerts/app.top.snackbar.dart';
import 'package:uae_meditation_center/core/alerts/loading.popup.dart';
import 'package:uae_meditation_center/core/popup/popup.window.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:uae_meditation_center/data/models/user.model.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';
import 'package:uae_meditation_center/presentation/components/app.input.dart';
import 'package:uae_meditation_center/presentation/components/introduction.text.dart';
import 'package:uae_meditation_center/presentation/components/user.card.dart';
import 'package:uae_meditation_center/providers/user.provider.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      conform(pickedFile);
    }
  }

// conform uploading
  conform(XFile imagePath) {
    return PopupWindow.conformImageUploadPopup(
      context,
      () async {
        context.pop();
        LoadingPopup.show('Uploading...');
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final userID = FirebaseAuth.instance.currentUser!.uid;

        final currentUser = await userProvider.getUserById(userID);
        // upload and update user
        final status = await userProvider.uploadUserProfileImage(
          imagePath,
          userID,
          context,
          currentUser,
        );
        if (status) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Successfully !',
              duration: const Duration(seconds: 2));
        } else {
          EasyLoading.dismiss();
          AppTopSnackbar.showTopSnackBar(context, "Upload failed !");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       resizeToAvoidBottomInset: false,
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
          'Account Settings',
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Consumer(
          builder: (
            BuildContext context,
            UserProvider userProvider,
            Widget? child,
          ) =>
              FutureBuilder(
            future: userProvider
                .getUserById(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              // error getting user
              if (snapshot.hasError) {
                EasyLoading.dismiss();
                AppTopSnackbar.showTopSnackBar(context, "Something went wrong");

                context.push('/main');
              }
              // loading user data
              if (snapshot.connectionState == ConnectionState.waiting) {
                LoadingPopup.show('Logging...');
              }
              // has user data

              if (snapshot.hasData) {
                EasyLoading.dismiss();
                final cUser = snapshot.data as UserModel;
                return Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    UserCard(
                      imageUrl: cUser.profileImage,
                      isEdit: true,
                      selectImage: () {
                        _pickImageFromGallery();
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    AppInput(
                      hintText: cUser.name,
                      prefixIcon: Icons.person,
                      suffixIcon: Icons.cancel_sharp,
                    ),
                    SizedBox(height: height * 0.02),
                    AppButtons(
                      width: double.infinity,
                      height: 48,
                      text: "Changes my name",
                      icon: Icons.change_circle,
                      isPrimary: false,
                    ),
                    SizedBox(height: height * 0.05),
                    IntroductionText.text(
                      theme,
                      "Click on the camera icon to change your profile picture",
                    ),
                    IntroductionText.text(
                      theme,
                      "Then select the image you want to use as your profile picture",
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
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
