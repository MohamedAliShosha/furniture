import 'package:flutter/material.dart';
import 'special_offers_view_bloc_builder.dart';

class SpecialOffersViewBody extends StatelessWidget {
  const SpecialOffersViewBody({
    super.key,
    required this.offerId,
  });

  final String offerId;

  @override
  Widget build(BuildContext context) {
    return SpecialOffersViewBlocBuilder(
      offerId: offerId,
    );
  }
}
