import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String text;
  const BookingCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Image.asset("assets/icons/circle.png", width: 50, height: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
