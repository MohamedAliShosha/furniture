import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/data/models/cart_item.dart';
import '../../../payment_methods/presentation/cubit/payment_method_cubit.dart';
import '../widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
    required this.cartItems,
    required this.total,
  });
  final List<CartItemModel> cartItems;
  final double total;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentMethodCubit>()..loadPaymentMethods(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppTexts.checkoutTitle,
        ),
        body: CheckoutViewBody(
          cartItems: cartItems,
          total: total,
        ),
      ),
    );
  }
}
