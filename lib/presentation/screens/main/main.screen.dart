import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uae_meditation_center/core/constans/app.constans.dart';
import 'package:uae_meditation_center/data/models/user.model.dart';
import 'package:uae_meditation_center/presentation/pages/booking/booking.page.dart';
import 'package:uae_meditation_center/presentation/pages/home/home.page.dart';
import 'package:uae_meditation_center/presentation/pages/notification/notification.page.dart';
import 'package:uae_meditation_center/presentation/pages/post/post.page.dart';
import 'package:uae_meditation_center/presentation/pages/chat%20room/chat.room.page.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';
import 'package:uae_meditation_center/data/services/user.services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void checkUser() async {
    final isUserIdExists = await UserServices()
        .isUserIdExists(FirebaseAuth.instance.currentUser!.uid);

    if (!isUserIdExists) {
      // user not exists, then add to collection
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        UserServices().addNewUser(
          UserModel(
            name: currentUser.displayName == null
                ? "User"
                : currentUser.displayName.toString(),
            email: currentUser.email.toString(),
            uid: currentUser.uid.toString(),
            profileImage: currentUser.photoURL == null
                ? AppData.baseUserUrl
                : currentUser.photoURL.toString(),
            isAdmin: false,
          ),
        );
      } else {
        // user not exists, then return to login
        if (!mounted) return;
        context.push('/login');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // checkUser status
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 500),
      length: 5,
      child: Builder(
        builder: (BuildContext innerContext) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Mediation center',
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      context.push('/settings');
                    },
                    icon: const Icon(Icons.account_circle),
                    color: AppColors.whiteColor,
                    iconSize: 40,
                  ),
                ),
              ],
              bottom: const TabBar(
                labelColor: AppColors.whiteColor,
                dividerColor: AppColors.primaryColor,
                automaticIndicatorColorAdjustment: true,
                unselectedLabelColor: AppColors.secondaryColor,
                indicatorColor: AppColors.primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.home_rounded, size: 25)),
                  Tab(icon: Icon(Icons.chat, size: 25)),
                  Tab(icon: Icon(Icons.add_circle_rounded, size: 25)),
                  Tab(icon: Icon(Icons.calendar_month_rounded, size: 25)),
                  Tab(icon: Icon(Icons.notifications, size: 25)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // HomePage
                HomePage(),
                // PlaylistPage
                ChatRoomPage(),

                // PostPage
                PostPage(),

                // BookingPage
                BookingPage(),

                // NotificationPage
                NotificationPage(),
              ],
            ),
          );
        },
      ),
    );
  }
}
