import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/app_texts.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../features/special_offer/presentation/cubit/special_offer_cubit.dart';
import '../widgets/special_offers_view_body.dart';

class SpecialOffersView extends StatefulWidget {
  const SpecialOffersView({super.key, required this.offerId});

  final String offerId;

  @override
  State<SpecialOffersView> createState() => _SpecialOffersViewState();
}

class _SpecialOffersViewState extends State<SpecialOffersView> {
  @override
  void initState() {
    super.initState();
    context.read<SpecialOfferCubit>().fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        elevation: 0,
        title: Text(
          AppTexts.specialOffer,
          style: AppConstants.headingStyle,
        ),
      ),
      body: SpecialOffersViewBody(
        offerId: widget.offerId,
      ),
    );
  }
}
