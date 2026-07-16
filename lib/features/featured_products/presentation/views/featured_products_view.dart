import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/cubit/featured_items/featured_items_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../widgets/featured_products_view_body.dart';

class FeaturedProductsView extends StatelessWidget {
  const FeaturedProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeaturedItemsCubit>()..fetchFeaturedItems(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppTexts.featuredItems,
            style: AppConstants.headingStyle,
          ),
        ),
        body: const FeaturedProductViewBody(),
      ),
    );
  }
}
