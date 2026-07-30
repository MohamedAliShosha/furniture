import 'package:flutter/material.dart';

import 'payment_methods_bloc_builder.dart';

class PaymentMethodViewBody extends StatelessWidget {
  const PaymentMethodViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PaymentMethodsBlocBuilder();
  }
}
