import 'package:flutter/material.dart';
import 'package:uae_meditation_center/presentation/components/app.buttons.dart';
import 'package:uae_meditation_center/core/theme/app.colors.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _textFormField(context),
          const SizedBox(height: 20),
          AppButtons(
            text: "Click to upload",
            isPrimary: true,
            icon: Icons.upload,
            width: double.infinity,
            height: 50,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _imageCard(
                      () {
                        // delete image
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageCard(VoidCallback deleteImage) {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            "assets/jpg/IMG-20240412-WA0001.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: AppColors.textColor.withOpacity(0.5),
          child: Center(
            child: IconButton(
              onPressed: deleteImage,
              icon: Icon(
                Icons.delete,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFormField(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      maxLines: 8,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.gray,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
