import 'package:flutter/material.dart';

import 'data_loading_widget.dart';

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const DataLoadingBlocBuilder();
  }
}
