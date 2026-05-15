import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../services/special_offers_service.dart';
import 'offer_card_widget.dart';

class OffersPageView extends StatefulWidget {
  const OffersPageView({super.key});

  @override
  State<OffersPageView> createState() => _OffersPageViewState();
}

class _OffersPageViewState extends State<OffersPageView> {
  int currentIndex = 0;

  late final SpecialOffersService specialOffersService;

  @override
  void initState() {
    super.initState();
    specialOffersService = SpecialOffersService();
  }

  @override
  Widget build(BuildContext context) {
    final offers = specialOffersService.specialOffersList;
    if (offers.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: OfferCardWidget(
                    index: index,
                    offer: offer,
                  ),
                );
              }),
        ),
        if (offers.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                offers.length,
                (index) {
                  final isActive = currentIndex == index;
                  return Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppConstants.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
