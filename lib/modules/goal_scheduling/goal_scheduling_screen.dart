import 'package:flutter/material.dart';
import '../../shared/components/common/custom_app_bar.dart';
import '../../core/constants/colors/app_colors.dart';
import '../../core/constants/app_constants.dart';

class GoalSchedulingScreen extends StatefulWidget {
  const GoalSchedulingScreen({super.key});

  @override
  State<GoalSchedulingScreen> createState() => _GoalSchedulingScreenState();
}

class _GoalSchedulingScreenState extends State<GoalSchedulingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Goal Scheduling'),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag, size: 64, color: AppColors.accentOrange),
            SizedBox(height: AppConstants.defaultPadding),
            Text(
              'Goal Scheduling Module',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Goal scheduling functionality will be implemented here',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
