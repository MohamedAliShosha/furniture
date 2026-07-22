import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import 'hero_image_with_shimmer.dart';

class BlogDetailsViewBody extends StatelessWidget {
  const BlogDetailsViewBody({
    super.key,
    required this.blogId,
    required this.imageUrl,
    required this.date,
    required this.readTime,
    required this.title,
  });

  final String blogId;
  final String imageUrl;
  final String date;
  final String readTime;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero image
        Hero(
          tag: 'blog_$blogId',
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: HeroImageWithShimmer(
              imageUrl: imageUrl,
            ),
          ),
        ),
        // content
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // meta information
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        readTime,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  // title
                  Text(
                    title,
                    style: AppConstants.headingStyle.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const Gap(24),
                  // content paragraph
                  Text(
                    'Choosing the right furniture is about more than filling a space. Well-designed pieces bring comfort, functionality, and personality to your home while creating an environment that reflects your unique style.',
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'When selecting furniture, consider the room size, color palette, and materials. Combining durable craftsmanship with timeless designs ensures that your investment remains both beautiful and practical for years to come.',
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Whether you prefer a modern, minimalist look or a warm, classic atmosphere, thoughtfully chosen furniture can transform any room into a welcoming space where family and friends enjoy spending time together.',
                    style: AppConstants.bodyStyle.copyWith(
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
