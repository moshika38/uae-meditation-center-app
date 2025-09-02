import 'package:flutter/material.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
 
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 8),
                      Text("Mediation Center",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Text("2 min", style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Hello! welcome to our new application here you can fine new updates and new events, you can publish or share your experiance with othere ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.gray,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
