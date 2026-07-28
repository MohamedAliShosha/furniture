import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../orders/data/models/shipping_address_model.dart';
import '../cubit/shipping_address_cubit.dart';
import 'address_detail_row.dart';
import 'default_badge.dart';
import 'show_add_and_edit_address_dialog.dart';

class ShippingAddressListTile extends StatelessWidget {
  const ShippingAddressListTile({
    super.key,
    required this.address,
  });

  final ShippingAddressModel address;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        children: [
          Expanded(
            child: Text(
              overflow: TextOverflow.ellipsis,
              address.name,
              style: AppConstants.titleStyle.copyWith(fontSize: 16),
            ),
          ),
          if (address.isDefault == true) const DefaultBadge(),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          AddressDetailRow(
            icon: Icons.location_on_outlined,
            title: address.address,
          ),
          const Gap(4),
          AddressDetailRow(
            icon: Icons.location_city_outlined,
            title: '${address.city}, ${address.state} ${address.zipcode}',
          ),
          const Gap(4),
          AddressDetailRow(
            icon: Icons.phone_outlined,
            title: address.phone,
          ),
        ],
      ),
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          if (!address.isDefault)
            const PopupMenuItem(
              value: 'make_default',
              child: Text(
                AppTexts.makeDefault,
              ),
            ),
          const PopupMenuItem(
            value: 'edit',
            child: Text(
              AppTexts.edit,
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text(
              AppTexts.delete,
            ),
          ),
        ],
        onSelected: (value) async {
          final cubit = context.read<ShippingAddressCubit>();
          switch (value) {
            case 'make_default':
              await cubit.setDefaultAddress(address.id);
              break;
            case 'edit':
              addAndEditAddressDialog(context, address: address);
              break;
            case 'delete':
              // show confirmation dialog
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    AppTexts.deleteAddressTitle,
                  ),
                  content: const Text(
                    AppTexts.deleteAddressConfirmation,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(AppTexts.cancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(AppTexts.delete),
                    ),
                  ],
                ),
              );
              if (shouldDelete == true) {
                await cubit.deleteAddress(address.id);
              }
              break;
          }
        },
      ),
    );
  }
}
