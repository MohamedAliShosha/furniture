import '../../../core/utils/app_images.dart';
import '../data/models/blog_model.dart';

class BlogService {
  final List<BlogModel> _blogs = [
    BlogModel(
      id: '1',
      title: 'The Ultimate Guide to Choosing the Perfect Sofa',
      excerpt:
          'Discover how to select the ideal sofa for your living room with our comprehensive guide. From styles to materials, we cover everything you need to know.',
      content:
          'Choosing the perfect sofa can be a daunting task, but with our ultimate guide, you’ll be able to find the ideal piece for your living room. We cover various styles, materials, and tips to help you make an informed decision.',
      author: 'Sarah Johnson',
      imageUrl: AppImages.blog1,
      date: '2 days ago',
      readTime: '5 min read',
      tags: ['Interior Design', 'Living Room', 'Furniture'],
    ),
    BlogModel(
      id: '2',
      title: '10 Must-Have Home Decor Items for a Stylish Living Room',
      excerpt:
          'Elevate your living room with these 10 essential home decor items. From statement rugs to chic lighting, we’ve got you covered.',
      content:
          'Transform your living room into a stylish haven with our list of 10 must-have home decor items. Whether you’re looking for statement pieces or subtle accents, these essentials will elevate your space.',
      imageUrl: AppImages.blog2,
      author: 'Michael Lee',
      date: '5 days ago',
      readTime: '7 min read',
      tags: ['Home Decor', 'Living Room', 'Style'],
    ),
    BlogModel(
      id: '3',
      title: 'How to Create a Cozy Reading Nook in Your Home',
      excerpt:
          'Learn how to design a cozy reading nook that invites relaxation and comfort. We share tips on furniture, lighting, and decor to create the perfect space.',
      content:
          'A cozy reading nook is the perfect escape within your home. With our tips on selecting the right furniture, lighting, and decor, you can create a space that invites relaxation and comfort for all your reading adventures.',
      imageUrl: AppImages.blog3,
      author: 'Emily Davis',
      date: '1 week ago',
      readTime: '6 min read',
      tags: ['Reading Nook', 'Home Design', 'Cozy Spaces'],
    ),
  ];

  /// Returns all blogs (unfiltered)
  List<BlogModel> getBlogs() {
    return _blogs;
  }

  /// Returns a specific blog by ID
  BlogModel? getBlogById(String id) {
    try {
      return _blogs.firstWhere(
        (blog) => blog.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  List<BlogModel> getBlogsByTag(String tag) {
    return _blogs.where((blog) => blog.tags.contains(tag)).toList();
  }

  List<String> getAllTags() {
    final Set<String> tags = {};
    for (var blog in _blogs) {
      tags.addAll(blog.tags);
    }
    return tags.toList()..sort(); // sort tags alphabetically for better UX
  }
}
