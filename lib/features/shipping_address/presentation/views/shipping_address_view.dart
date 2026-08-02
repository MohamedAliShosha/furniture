import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/shipping_address_cubit.dart';
import '../widgets/shipping_addresses_view_body.dart';
import '../widgets/show_add_and_edit_address_dialog.dart';

class ShippingAddressView extends StatelessWidget {
  const ShippingAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShippingAddressCubit>()..loadAddresses(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          title: AppTexts.shippingAddress,
          actions: [
            IconButton(
              onPressed: () {
                addAndEditAddressDialog(context);
              },
              icon: const Icon(
                color: AppColors.primary,
                Icons.add,
              ),
            )
          ],
        ),
        body: const ShippingAddressesViewBody(),
      ),
    );
  }
}
