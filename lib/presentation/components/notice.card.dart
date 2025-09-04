import 'package:flutter/material.dart';
import 'package:uae_meditation_center/presentation/pages/comments/comment.page.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // user info
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  "https://randomuser.me/api/portraits/men/1.jpg",
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SAP Moshika",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "1 min ago",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.gray, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // content
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                _imageCard(context, false),
                const SizedBox(height: 10),
                _imageCard(context, true),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("20 like", style: Theme.of(context).textTheme.bodySmall),
              Text("2 comments", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),

          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionBtn(context, Icons.thumb_up, "Like", () {}),
              _actionBtn(
                context,
                Icons.comment,
                "Comment",
                () {
                  CommentPage.bottomSheet(context);
                },
              ),
              _actionBtn(context, Icons.share_outlined, "Share", () {}),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _actionBtn(
      BuildContext context, IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.gray,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _imageCard(BuildContext context, bool lastChild) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/jpg/IMG-20240412-WA0001.jpg',
          width: MediaQuery.of(context).size.width * 0.43,
          height: 150,
          fit: BoxFit.contain,
        ),
        Stack(
          children: [
            Image.asset(
              'assets/jpg/IMG-20240412-WA0001.jpg',
              width: MediaQuery.of(context).size.width * 0.43,
              height: 150,
              fit: BoxFit.contain,
            ),
            lastChild
                ? Container(
                    color: const Color.fromARGB(143, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 200,
                    child: Center(
                        child: Text(
                      "4 +",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    )),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
