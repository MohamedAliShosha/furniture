import 'package:flutter/material.dart';

import 'shimmer_loading.dart';

class BlogImageWithShimmer extends StatefulWidget {
  const BlogImageWithShimmer({
    super.key,
    required this.imageUrl,
    required this.blogId,
  });

  final String imageUrl;
  final String blogId;

  @override
  State<BlogImageWithShimmer> createState() => _BlogImageWithShimmerState();
}

class _BlogImageWithShimmerState extends State<BlogImageWithShimmer> {
  ImageProvider? _imageProvider;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  initState() {
    super.initState();
    updateImageProvider();
  }

  @override
  void didUpdateWidget(covariant BlogImageWithShimmer oldWidget) {
    if (oldWidget.imageUrl != widget.imageUrl) {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
      updateImageProvider();
    }
    super.didUpdateWidget(oldWidget);
  }

  void updateImageProvider() {
    _imageProvider = AssetImage(widget.imageUrl);
    loadImage();
  }

  void loadImage() {
    if (_imageProvider == null) return;
    final ImageStream imageStream =
        _imageProvider!.resolve(ImageConfiguration.empty);
    imageStream.addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          if (mounted && _isLoading) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        onError: (dynamic error, StackTrace? stackTrace) {
          if (mounted && !_hasError) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(
            Icons.image,
            color: Colors.grey,
            size: 50,
          ),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        ShimmerLoading(
          isLoading: _isLoading,
          child: Container(
            color: Colors.white,
          ),
        ),
        if (_imageProvider != null)
          Image(
            image: _imageProvider!,
            // use blogId as key to force the image to reload when the blog changes
            key: ValueKey('${widget.blogId}_${widget.imageUrl}'),
            fit: BoxFit.cover,
          ),
      ],
    );
  }
}
