import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_error_state.dart';
import '../../../../core/widgets/custom_loading_state.dart';
import '../cubit/shipping_address_cubit.dart';
import '../cubit/shipping_address_state.dart';
import 'shipping_addresses_list_view.dart';

class ShippingAddressViewBlocBuilder extends StatelessWidget {
  const ShippingAddressViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
      builder: (context, state) {
        if (state is ShippingAddressLoading) {
          return const CustomLoadingState();
        }

        if (state is ShippingAddressFailure) {
          return CustomErrorState(
            message: state.message,
            onRetry: () {
              context.read<ShippingAddressCubit>().loadAddresses();
            },
            retryLabel: AppTexts.retry,
          );
        }

        if (state is ShippingAddressSuccess) {
          final addresses = state.addresses;

          if (addresses.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const Gap(16),
                Text(
                  AppTexts.noAddressesAddedYet,
                  style: AppConstants.titleStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            );
          }

          return ShippingAddressesListView(addresses: addresses);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
