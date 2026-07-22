import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_router.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/constants.dart';
import '../../../home/presentation/widgets/animated_list_item.dart';
import '../../data/models/blog_model.dart';
import 'blog_image_with_shimmer.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
    required this.index,
  });

  final BlogModel blog;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedListItem(
      index: index,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'blog_${blog.id}',
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BlogImageWithShimmer(
                      imageUrl: blog.imageUrl,
                      blogId: blog.id,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          blog.date,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Text(
                      blog.readTime,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      blog.title,
                      style: AppConstants.titleStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      blog.excerpt,
                      style: AppConstants.bodyStyle.copyWith(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const Gap(8),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Read more',
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppConstants.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          // Navigate to blog details page
          GoRouter.of(context).push(
            AppRouter.kBlogDetailsView,
            extra: blog,
          );
        },
      ),
    );
  }
}
