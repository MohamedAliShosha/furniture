import 'package:flutter/material.dart';

import 'data_loading_bloc_builder.dart';

class HomeViewContent extends StatelessWidget {
  const HomeViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const DataLoadingBlocBuilder();
  }
}
