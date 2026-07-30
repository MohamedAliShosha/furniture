import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/features/payment_methods/data/models/payment_method_model.dart';
import 'package:furniture/features/payment_methods/presentation/cubit/payment_method_cubit.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';

class AddAndEditCardDialog extends StatefulWidget {
  const AddAndEditCardDialog(
      {super.key, this.paymentMethod, required this.cubit});

  final PaymentMethodModel? paymentMethod;
  final PaymentMethodCubit cubit;

  @override
  State<AddAndEditCardDialog> createState() => _AddAndEditCardDialogState();
}

class _AddAndEditCardDialogState extends State<AddAndEditCardDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cardNumberController;
  late final TextEditingController _expireDateController;
  late final TextEditingController _cardHolderNameController;
  late bool _isDefault;
  String _selectedColor = '0xFF1A237E';
  String? _selectedCardType;

  @override
  void initState() {
    _cardNumberController =
        TextEditingController(text: widget.paymentMethod?.cardNumber);
    _expireDateController =
        TextEditingController(text: widget.paymentMethod?.expireDate);
    _cardHolderNameController =
        TextEditingController(text: widget.paymentMethod?.cardHolderName);

    _isDefault = widget.paymentMethod?.isDefault ?? false;
    _selectedColor = (widget.paymentMethod?.cardColors ?? '0XFF1A237E');
    _selectedCardType = ['Visa', 'Mastercard', 'American Express']
            .contains(widget.paymentMethod?.cardType)
        ? widget.paymentMethod?.cardType
        : 'Visa';
    super.initState();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expireDateController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.paymentMethod == null ? AppTexts.addNewCard : AppTexts.editCard,
        style: AppConstants.titleStyle,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Creates a [DropdownButton] widget that is a [FormField], wrapped in an [InputDecorator]
              DropdownButtonFormField<String>(
                value: _selectedCardType ?? AppTexts.visa,
                decoration: const InputDecoration(
                  labelText: AppTexts.cardType,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Visa',
                    child: Text(AppTexts.visa),
                  ),
                  DropdownMenuItem(
                    value: 'Mastercard',
                    child: Text(AppTexts.mastercard),
                  ),
                  DropdownMenuItem(
                    value: 'American Express',
                    child: Text(AppTexts.americanExpress),
                  ),
                ],
                validator: (value) =>
                    value == null ? AppTexts.pleaseSelectCardType : null,
                onChanged: (value) {
                  setState(() {
                    _selectedCardType = value;
                  });
                },
              ),
              const Gap(16),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: AppTexts.cardNumberLabel,
                ),
                validator: (value) => value?.isEmpty == true
                    ? AppTexts.pleaseEnterCardNumber
                    : null,
              ),

              const Gap(16),
              TextFormField(
                controller: _expireDateController,
                decoration: const InputDecoration(
                  labelText: AppTexts.expireDateLabel,
                ),
                validator: (value) => value?.isEmpty == true
                    ? AppTexts.pleaseEnterExpireDate
                    : null,
              ),
              const Gap(16),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: const InputDecoration(
                  labelText: AppTexts.cardHolderNameLabel,
                ),
                validator: (value) => value?.isEmpty == true
                    ? AppTexts.pleaseEnterCardHolderName
                    : null,
              ),
              const Gap(16),

              DropdownButtonFormField<String>(
                  decoration:
                      const InputDecoration(labelText: AppTexts.cardColor),
                  value: _selectedColor,
                  items: [
                    DropdownMenuItem(
                      value: '0XFF1A237E',
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0XFF1A237E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Gap(8),
                          const Text(
                            AppTexts.blue,
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: '0XFF871C1C',
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0XFF871C1C),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Gap(8),
                          const Text(
                            AppTexts.red,
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: '0XFF1B5E2D',
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0XFF1B5E2D),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Gap(8),
                          const Text(
                            AppTexts.green,
                          ),
                        ],
                      ),
                    )
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedColor = value;
                      });
                    }
                  }),
              const Gap(16),
              CheckboxListTile(
                value: _isDefault,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value ?? false;
                  });
                },
                title: const Text(AppTexts.setAsDefaultCard),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppTexts.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () async {
            await _saveCard(context);
          },
          child: Text(
            widget.paymentMethod == null
                ? AppTexts.addButton
                : AppTexts.saveButton,
            style: const TextStyle(color: AppColors.white),
          ),
        )
      ],
    );
  }

  Future<void> _saveCard(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      final newMethod = PaymentMethodModel(
        id: widget.paymentMethod?.id ?? '',
        cardType: _selectedCardType ?? '',
        cardNumber: _cardNumberController.text,
        expireDate: _expireDateController.text,
        cardHolderName: _cardHolderNameController.text,
        isDefault: _isDefault,
        cardColors: _selectedColor,
      );
      if (widget.paymentMethod != null) {
        await widget.cubit.updatePaymentMethod(newMethod);
      } else {
        await widget.cubit.addPaymentMethod(newMethod);
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
