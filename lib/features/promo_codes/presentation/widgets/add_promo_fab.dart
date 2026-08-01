import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'add_promo_code_dialog.dart';
import '../cubit/promo_code_cubit.dart';

class AddPromoFloatingActionButton extends StatelessWidget {
  const AddPromoFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (fabContext) => FloatingActionButton(
        onPressed: () {
          final promoCodeCubit = fabContext.read<PromoCodeCubit>();
          showDialog(
            context: fabContext,
            builder: (dialogContext) => BlocProvider.value(
              value: promoCodeCubit,
              child: const AddPromoCodeDialog(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
