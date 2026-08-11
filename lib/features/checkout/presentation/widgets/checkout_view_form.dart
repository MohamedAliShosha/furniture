import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_texts.dart';

class CheckoutViewForm extends StatelessWidget {
  const CheckoutViewForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController addressController,
    required TextEditingController cityController,
    required TextEditingController stateController,
    required TextEditingController zipCodeController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _emailController = emailController,
        _phoneController = phoneController,
        _addressController = addressController,
        _cityController = cityController,
        _stateController = stateController,
        _zipCodeController = zipCodeController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _phoneController;
  final TextEditingController _addressController;
  final TextEditingController _cityController;
  final TextEditingController _stateController;
  final TextEditingController _zipCodeController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: AppTexts.fullNameLabel,
              prefixIcon: Icon(Icons.person_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.fullNameRequired;
              }
              return null;
            },
          ),
          const Gap(16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: AppTexts.emailLabel,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.emailRequired;
              }
              // Basic email validation
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return AppTexts.invalidEmail;
              }
              return null;
            },
          ),
          const Gap(16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: AppTexts.phoneNumberLabel,
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.phoneNumberRequired;
              }

              return null;
            },
          ),
          const Gap(16),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: AppTexts.streetAddressLabel,
              prefixIcon: Icon(Icons.home_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.streetAddressRequired;
              }
              return null;
            },
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: AppTexts.cityLabel,
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppTexts.cityRequired;
                    }
                    return null;
                  },
                ),
              ),
              const Gap(12),
              Expanded(
                child: TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: AppTexts.stateLabel,
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppTexts.stateRequired;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _zipCodeController,
            decoration: const InputDecoration(
              labelText: AppTexts.zipCodeLabel,
              prefixIcon: Icon(Icons.pin_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.zipCodeRequired;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
