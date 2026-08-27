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
      child: const _OrdersHistoryViewBody(),
    );
  }
}

class _OrdersHistoryViewBody extends StatefulWidget {
  const _OrdersHistoryViewBody();

  @override
  State<_OrdersHistoryViewBody> createState() => _OrdersHistoryViewBodyState();
}

class _OrdersHistoryViewBodyState extends State<_OrdersHistoryViewBody> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppTexts.myOrders,
      ),
      body: Column(
        children: [
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
            child: TabBar(
              controller: _tabController,
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
            child: TabBarView(
              controller: _tabController,
              children: const [
                OrdersListBlocBuilder(type: OrderTypeEnum.active),
                OrdersListBlocBuilder(type: OrderTypeEnum.completed),
                OrdersListBlocBuilder(type: OrderTypeEnum.cancelled),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
