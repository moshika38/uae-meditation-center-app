import 'package:flutter/material.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';

class PopupWindow {
  static void conformImageUploadPopup(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Conform to upload image',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: theme.textTheme.bodyMedium),
          ),
          AppButtons(
            onTap: onConfirm,
            text: "Upload",
            isPrimary: true,
            icon: Icons.upload,
            height: 40,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ],
      ),
    );
  }
}
