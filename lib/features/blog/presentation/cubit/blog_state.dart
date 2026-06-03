import '../../data/models/blog_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogSuccess extends BlogState {
  final List<BlogModel> blogs;
  final List<String> allTags;
  final String? selectedTag;

  BlogSuccess({
    required this.blogs,
    required this.allTags,
    this.selectedTag,
  });
}

class BlogFailure extends BlogState {
  final String message;

  BlogFailure(this.message);
}
