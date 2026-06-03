import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/blog_service.dart';
import 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogService blogService;
  String? _selectedTag;

  BlogCubit(this.blogService) : super(BlogInitial());

  Future<void> fetchBlogs() async {
    _emitBlogData();
  }

  Future<void> selectTag(String? tag) async {
    if (_selectedTag == tag) {
      _selectedTag = null; // Deselect if the same tag is selected again
    } else {
      _selectedTag = tag; // Select the new tag
    }
    _emitBlogData();
  }

  Future<void> getBlogById(String id) async {
    emit(BlogLoading());
    try {
      final blog = blogService.getBlogById(id);
      final allTags = blogService.getAllTags();
      emit(
        BlogSuccess(
          blogs: [blog!],
          allTags: allTags,
          selectedTag: _selectedTag,
        ),
      );
    } catch (e) {
      emit(BlogFailure(e.toString()));
    }
  }

  String? getSelectedTag() => _selectedTag;

  void _emitBlogData() {
    emit(BlogLoading());
    try {
      final blogs = _selectedTag == null
          ? blogService.getBlogs()
          : blogService.getBlogsByTag(_selectedTag!);
      final allTags = blogService.getAllTags();
      emit(
        BlogSuccess(
          blogs: blogs,
          allTags: allTags,
          selectedTag: _selectedTag,
        ),
      );
    } catch (e) {
      emit(
        BlogFailure(
          e.toString(),
        ),
      );
    }
  }
}
