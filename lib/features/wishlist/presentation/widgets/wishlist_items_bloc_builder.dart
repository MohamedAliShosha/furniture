import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../cart/presentation/widgets/empty_wishlist_widget.dart';
import '../../../home/presentation/widgets/featured_item_card.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/wishlist_state.dart';

class WisListItemsBloBuilder extends StatelessWidget {
  const WisListItemsBloBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is WishlistFailure) {
          return Center(
            child: Text('${AppTexts.errorPrefix} ${state.message}'),
          );
        } else if (state is WishlistSuccess) {
          if (state.wishListedItems.isEmpty) {
            return const EmptyWisListWidget();
          }
          return GridView.builder(
            padding: const EdgeInsets.all(
              AppConstants.defaultPadding,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: state.wishListedItems.length,
            itemBuilder: (context, index) {
              final product = state.wishListedItems[index];
              return FeaturedItemCard(
                productModel: product,
                onTap: () {
                  // navigate to product details screen
                },
              );
            },
          );
        }
        return const EmptyWisListWidget();
      },
    );
  }
}
