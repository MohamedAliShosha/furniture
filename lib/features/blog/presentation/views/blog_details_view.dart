import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/blog_details_view_body.dart';

class BlogDetailsView extends StatelessWidget {
  const BlogDetailsView({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.readTime,
    required this.blogId,
  });

  final String title;
  final String imageUrl;
  final String date;
  final String readTime;
  final String blogId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlogDetailsViewBody(
        blogId: blogId,
        imageUrl: imageUrl,
        date: date,
        readTime: readTime,
        title: title,
      ),
    );
  }
}
