import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_router.dart';
import 'package:furniture/core/widgets/state_widgets.dart';
import 'package:furniture/features/home/presentation/widgets/animated_list_item.dart';
import 'package:furniture/features/home/presentation/widgets/featured_item_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../cubit/special_offer_cubit.dart';
import '../cubit/special_offer_state.dart';

class SpecialOffersViewBlocBuilder extends StatelessWidget {
  const SpecialOffersViewBlocBuilder({
    super.key,
    required this.offerId,
  });

  final String offerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialOfferCubit, SpecialOfferState>(
      builder: (context, state) {
        final specialOfferCubit = context.read<SpecialOfferCubit>();
        final offer = specialOfferCubit.getOfferById(offerId);

        if (state is SpecialOfferLoading) {
          return const CustomLoadingState();
        }

        if (offer == null) {
          return CustomErrorState(
            message: state is SpecialOfferFailure
                ? state.message
                : AppTexts.offerNotFound,
            icon: Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
          );
        }

        final applicableItems = specialOfferCubit.getApplicableItems(offer);

        if (applicableItems.isEmpty) {
          return const CustomEmptyState(
            message: AppTexts.noItemsAvailableForOffer,
            subtitle: AppTexts.checkBackLaterForNewItems,
            icon: Icon(
              Icons.local_offer_outlined,
              size: 64,
              color: Colors.grey,
            ),
          );
        }

        return CustomSuccessState(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppConstants.defaultPadding,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppConstants.defaultBorderRadius,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.title,
                          style: AppConstants.titleStyle.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          offer.description,
                          style: AppConstants.bodyStyle.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Text(
                            '${offer.discountPercentage.toStringAsFixed(0)}% Off',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(
                  AppConstants.defaultPadding,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = applicableItems[index];
                    return AnimatedListItem(
                      isVertical: false,
                      index: index,
                      child: Hero(
                        tag: 'special_offer_${item.id}',
                        child: FeaturedItemCard(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kProductDetailsView,
                              extra: item,
                            );
                          },
                          productModel: item,
                        ),
                      ),
                    );
                  }, childCount: applicableItems.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
