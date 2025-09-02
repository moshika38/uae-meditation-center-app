import 'package:flutter/material.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';
import 'package:uae_meditation_center/presentation/components/booking.card.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List menuItems = [
      "මාසික සමාජිකත්වය ලබා ගැනීම සඳහා",
      "දානමය පිංකම් භාරගැනීම සඳහා",
      "⁠සම්බුද්ධ වන්දානා පිංකම භාරගැනීම සඳහා",
      "⁠ආලෝක පූජාව භාරගැනීම සඳහා",
      "⁠විශේෂ පිංකම් පිළිබඳ විස්තර",
      "⁠ඉදිරි වැඩසටහන් පෙළගැස්ම",
      "⁠whatsapp එකමුතුවට සම්බන්ධ වීම සඳහා",
      "⁠අප සන්නිවේදන ජාලය",
      "⁠අප හා සම්බන්ධ වීමට",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AppButtons(
                    text: "Add",
                    isPrimary: true,
                    width: 100,
                    height: 33,
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: menuItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BookingCard(
                  text: menuItems[index],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
