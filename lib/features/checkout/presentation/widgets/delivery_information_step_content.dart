import 'package:flutter/material.dart';
import 'checkout_view_form.dart';

class DeliveryInformationStepContent extends StatelessWidget {
  const DeliveryInformationStepContent({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;

  @override
  Widget build(BuildContext context) {
    return CheckoutViewForm(
      formKey: formKey,
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
      addressController: addressController,
      cityController: cityController,
      stateController: stateController,
      zipCodeController: zipCodeController,
    );
  }
}
