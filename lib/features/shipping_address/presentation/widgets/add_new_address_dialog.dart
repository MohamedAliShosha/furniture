import 'package:flutter/material.dart';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/core/utils/constants.dart';
import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import 'package:furniture/features/shipping_address/presentation/cubit/shipping_address_cubit.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';

class AddAndEditAddressDialog extends StatefulWidget {
  const AddAndEditAddressDialog(
      {super.key, this.shippingAddress, required this.cubit});

  final ShippingAddressModel? shippingAddress;
  final ShippingAddressCubit cubit; // Add this

  @override
  State<AddAndEditAddressDialog> createState() =>
      _AddAndEditAddressDialogState();
}

class _AddAndEditAddressDialogState extends State<AddAndEditAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _phoneController;
  late bool _isDefault;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.shippingAddress?.name);
    _addressController =
        TextEditingController(text: widget.shippingAddress?.address);
    _cityController = TextEditingController(text: widget.shippingAddress?.city);
    _stateController =
        TextEditingController(text: widget.shippingAddress?.state);
    _zipCodeController =
        TextEditingController(text: widget.shippingAddress?.zipcode);
    _phoneController =
        TextEditingController(text: widget.shippingAddress?.phone);
    _isDefault = widget.shippingAddress?.isDefault ?? false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.shippingAddress == null
            ? AppTexts.addNewAddress
            : AppTexts.editAddress,
        style: AppConstants.titleStyle,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: AppTexts.addressNameLabel),
                validator: (value) =>
                    value?.isEmpty == true ? AppTexts.addressNameRequired : null,
              ),
              const Gap(16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: AppTexts.streetAddressLabel,
                ),
                validator: (value) =>
                    value?.isEmpty == true ? AppTexts.streetAddressRequired : null,
              ),
              const Gap(16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter a city' : null,
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(
                        labelText: 'State',
                      ),
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter a state'
                          : null,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: TextFormField(
                      controller: _zipCodeController,
                      decoration: const InputDecoration(
                        labelText: 'ZIP Code',
                      ),
                      validator: (value) => value?.isEmpty == true
                          ? 'Please enter a ZIP code'
                          : null,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) => value?.isEmpty == true
                    ? 'Please enter a phone number'
                    : null,
              ),
              const Gap(16),
              CheckboxListTile(
                value: _isDefault,
                onChanged: (value) {
                  setState(
                    () {
                      _isDefault = value ?? false;
                    },
                  );
                },
                title: const Text(
                  'Set as default address',
                ),
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
          child: const Text(
            AppTexts.cancel,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () async {
            if (_formKey.currentState?.validate() == true) {
              final newAddress = ShippingAddressModel(
                id: widget.shippingAddress?.id ??
                    '', // empty id for new address
                name: _nameController.text,
                address: _addressController.text,
                city: _cityController.text,
                state: _stateController.text,
                zipcode: _zipCodeController.text,
                phone: _phoneController.text,
                isDefault: _isDefault,
              );
              if (widget.shippingAddress != null) {
                await widget.cubit.updateAddress(newAddress);
              } else {
                await widget.cubit.addAddress(newAddress);
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: Text(
            widget.shippingAddress == null ? 'Add' : 'Save',
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
