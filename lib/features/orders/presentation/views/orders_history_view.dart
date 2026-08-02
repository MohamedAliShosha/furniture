import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_texts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/enums/orders_type_enum.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/orders_list_bloc_builder.dart';

class OrdersHistoryView extends StatelessWidget {
  const OrdersHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrdersCubit>()..loadOrders(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(
          title: AppTexts.myOrders,
        ),
        // DefaultTabController creates and owns the controller instead of creating a stateful widget and controllers for the taps
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              // This the container that holds the 3 taps of the tapBar
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.defaultPadding,
                ),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                // TabBar — the row of tappable labels
                child: TabBar(
                  labelColor: AppColors.white,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.all(3),
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  tabs: const [
                    Tab(
                      text: AppTexts.active,
                    ),
                    Tab(
                      text: AppTexts.completed,
                    ),
                    Tab(
                      text: AppTexts.canceled,
                    ),
                  ],
                ),
              ),
              Expanded(
                // TabBarView — the swipeable content area
                child: TabBarView(
                  children: [
                    _buildOrdersList(type: OrderTypeEnum.active),
                    _buildOrdersList(type: OrderTypeEnum.completed),
                    _buildOrdersList(type: OrderTypeEnum.cancelled),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList({required OrderTypeEnum type}) {
    return OrdersListBlocBuilder(
      type: type,
    );
  }
}
