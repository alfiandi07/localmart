import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/app_color.dart';
import 'package:localmart/Day_20/Constants/app_images.dart';

class Testday20 extends StatelessWidget {
  const Testday20({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Image.asset(AppImages.dragonBall),
          Image.asset(AppImages.fb),
        ],
      ),
    );
  }
}
