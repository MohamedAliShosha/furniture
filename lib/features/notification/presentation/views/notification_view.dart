import 'package:flutter/material.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.notificationTitle,
      ),
      body: SafeArea(
        child: NotificationViewBody(),
      ),
    );
  }
}
