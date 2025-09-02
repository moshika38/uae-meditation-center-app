import 'package:flutter/material.dart';
import 'package:uae_meditation_center/presentation/components/notice.card.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
             NoticeCard(),
            NoticeCard(),
            NoticeCard(),
          ],
        ),
      ),
    );
  }
}
