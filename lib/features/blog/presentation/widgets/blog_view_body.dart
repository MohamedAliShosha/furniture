import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/constants.dart';
import 'blog_view_tags_bloc_builder.dart';
import 'blogs_bloc_builder.dart';

class BlogViewBody extends StatelessWidget {
  const BlogViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: AppConstants.defaultPadding,
            right: AppConstants.defaultPadding,
            bottom: AppConstants.defaultPadding,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Blog',
                style: AppConstants.headingStyle,
              ),
              const Gap(8),
              Text(
                'Get inspired with furniture tips & trends.',
                style: AppConstants.bodyStyle.copyWith(color: Colors.grey),
              ),
              const Gap(16),
              const BlogViewTagsBlocBuilder(),
            ],
          ),
        ),
        const Expanded(
          child: BlogsBlocBuilder(),
        ),
      ],
    );
  }
}
