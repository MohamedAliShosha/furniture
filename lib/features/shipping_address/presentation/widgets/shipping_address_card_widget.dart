import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/shipping_address/presentation/cubit/shipping_address_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../features/orders/data/models/shipping_address_model.dart';
import 'shipping_address_list_tile.dart';

class ShippingAddressCardWidget extends StatelessWidget {
  const ShippingAddressCardWidget({
    super.key,
    required this.address,
  });

  final ShippingAddressModel address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          ShippingAddressListTile(
            address: address,
          ),
          if (!address.isDefault)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppConstants.primaryColor,
                ),
                onPressed: () {
                  context
                      .read<ShippingAddressCubit>()
                      .setDefaultAddress(address.id);
                },
                child: const Text(
                  AppTexts.setAsDefault,
                ),
              ),
            )
        ],
      ),
    );
  }
}
