class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

// Overriding "toString" here ensures that when you print the exception, you’ll just see the clean message instead of something like Instance of 'CustomException'.
  @override
  String toString() {
    return message;
  }
}
