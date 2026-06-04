import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants.dart';
import '../cubit/blog_cubit.dart';
import '../cubit/blog_state.dart';
import 'blog_card.dart';

class BlogsBlocBuilder extends StatelessWidget {
  const BlogsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, BlogState>(
      builder: (context, state) {
        if (state is BlogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BlogSuccess) {
          final blogs = state.blogs;
          if (blogs.isEmpty) {
            return const Center(
              child: Text('No posts found.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(
              AppConstants.defaultPadding,
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final post = blogs[index];
              return BlogCard(index: index, blog: post);
            },
          );
        } else if (state is BlogFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
