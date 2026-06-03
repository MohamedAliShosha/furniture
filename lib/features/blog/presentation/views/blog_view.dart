import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/blog/presentation/cubit/blog_cubit.dart';
import '../widgets/blog_view_body.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    super.initState();
    // Initialize with all blogs on first load
    context.read<BlogCubit>().fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BlogViewBody(),
    );
  }
}
