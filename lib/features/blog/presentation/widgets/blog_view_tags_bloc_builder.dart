import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import '../cubit/blog_state.dart';

class BlogViewTagsBlocBuilder extends StatelessWidget {
  const BlogViewTagsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, BlogState>(
      builder: (context, state) {
        if (state is BlogSuccess) {
          final tags = state.allTags;
          final selectedTag = state.selectedTag;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: AppConstants.defaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Topics',
                      style: AppConstants.titleStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (selectedTag != null)
                      GestureDetector(
                        onTap: () {
                          context.read<BlogCubit>().selectTag(null);
                        },
                        child: const Text(
                          'Clear Filter',
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Gap(12),
              SizedBox(
                height: 34,
                child: ListView.builder(
                  itemCount: tags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    final isSelected = tag == selectedTag;
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index == tags.length - 1
                              ? AppConstants.defaultPadding
                              : 8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<BlogCubit>().selectTag(tag);
                          },
                          borderRadius: BorderRadius.circular(17),
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppConstants.primaryColor.withOpacity(0.1)
                                  : Colors.grey[50],
                              border: Border.all(
                                color: isSelected
                                    ? AppConstants.primaryColor
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppConstants.primaryColor
                                          : Colors.grey[700],
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const Gap(4),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: AppConstants.primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
