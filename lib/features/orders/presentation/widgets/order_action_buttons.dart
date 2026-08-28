import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/app_texts.dart';
import '../../data/enums/order_status_enum.dart';
import '../../data/models/order_model.dart';
import '../cubit/orders_cubit.dart';

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 300;
      final buttonFlex = isWide ? 1 : 0;

      return Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ElevatedButton(
              onPressed: () => _showTrackingSnackBar(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.defaultBorderRadius),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text(
                AppTexts.trackOrder,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (order.status == OrderStatusEnum.processing) ...[
            SizedBox(
              height: isWide ? 0 : 12,
              width: isWide ? 12 : 0,
            ),
            Flexible(
              flex: buttonFlex,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.defaultBorderRadius),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 0),
                ),
                onPressed: () => _confirmAndCancel(context),
                child: const Text(AppTexts.cancelOrder),
              ),
            )
          ]
        ],
      );
    });
  }

  void _showTrackingSnackBar(BuildContext context) {
    if (order.trackingNumber != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: Text('${AppTexts.trackingNumber}${order.trackingNumber}'),
          ),
        ),
      );
    }
  }

  Future<void> _confirmAndCancel(BuildContext context) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTexts.cancelOrder),
        content: const Text(AppTexts.cancelOrderConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppTexts.noButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppTexts.yesButton),
          ),
        ],
      ),
    );

    if (shouldCancel == true && context.mounted) {
      await context.read<OrdersCubit>().cancelOrder(order.id);
    }
  }
}
