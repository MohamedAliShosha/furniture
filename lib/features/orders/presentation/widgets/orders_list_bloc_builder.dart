import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/widgets/custom_error_state.dart';
import '../../../../core/widgets/custom_loading_state.dart';
import '../../../../core/widgets/custom_empty_state.dart';
import '../../data/enums/orders_type_enum.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import 'orders_list_view.dart';

class OrdersListBlocBuilder extends StatelessWidget {
  const OrdersListBlocBuilder({
    super.key,
    required this.type,
  });

  final OrderTypeEnum type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const CustomLoadingState();
        }

        if (state is OrderFailure) {
          return CustomErrorState(message: state.message);
        }

        if (state is OrderSuccess) {
          final cubit = context.read<OrdersCubit>();

          final orders = switch (type) {
            OrderTypeEnum.active => cubit.orderService.activeOrders,
            OrderTypeEnum.completed => cubit.orderService.completedOrders,
            OrderTypeEnum.cancelled => cubit.orderService.cancelledOrders,
          };

          if (orders.isEmpty) {
            return CustomEmptyState(
              message: _getEmptyStateText(),
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
            );
          }

          return OrdersListView(orders: orders);
        }

        return const SizedBox.shrink();
      },
    );
  }

  String _getEmptyStateText() {
    return switch (type) {
      OrderTypeEnum.active => AppTexts.noActiveOrdersFound,
      OrderTypeEnum.completed => AppTexts.noCompletedOrdersFound,
      OrderTypeEnum.cancelled => AppTexts.noCancelledOrdersFound,
    };
  }
}
