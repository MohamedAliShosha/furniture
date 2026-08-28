import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:furniture/features/orders/data/enums/order_status_enum.dart';
import 'package:furniture/features/orders/data/models/order_item_model.dart';
import 'package:furniture/features/orders/data/models/order_model.dart';
import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import 'package:furniture/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../home/data/models/cart_item.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../payment_methods/service/payment_method_service.dart';
import '../../../shipping_address/service/shipping_address_service.dart';
import 'delivery_information_step_content.dart';
import 'order_submission_dialog.dart';
import 'order_summary_step_content.dart';
import 'payment_method_step_content.dart';

// Stateful widget that manages the entire checkout flow across 3 steps
class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({
    super.key,
    required this.cartItems,
    required this.total,
  });

  // List of products/items in the shopping cart
  final List<CartItemModel> cartItems;
  // Total price calculated from all cart items
  final double total;

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  // Tracks which step (0, 1, or 2) the user is currently on in the stepper
  int _currentStep = 0;
  // Stores the ID of the selected payment method (null if none selected)
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    // Schedule callback after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDefaultAddress();
      _loadDefaultPaymentMethod();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadDefaultAddress() async {
    try {
      final shippingAddressService = getIt<ShippingAddressService>();
      await shippingAddressService.loadAddresses();
      final userCubit = getIt<UserCubit>();

      if (userCubit.isUserLoggedIn()) {
        // Get the user's default/primary address from the service
        final defaultAddress = shippingAddressService.defaultAddress;
        // Get the currently logged-in user's information
        final currentUser = userCubit.getCurrentUser();

        // Check if a default address exists for this user
        if (defaultAddress != null) {
          // Pre-fill user data field with the user data from default address
          _nameController.text = defaultAddress.name;
          _emailController.text = currentUser?.email ?? '';
          _addressController.text = defaultAddress.address;
          _cityController.text = defaultAddress.city;
          _stateController.text = defaultAddress.state;
          _zipCodeController.text = defaultAddress.zipcode;
          _phoneController.text = defaultAddress.phone;
        } else {
          // If no saved address, pre-fill with user's name from profile
          _nameController.text = currentUser?.name ?? '';
          // If no saved address, pre-fill with user's email from profile
          _emailController.text = currentUser?.email ?? '';
        }
      }
    } catch (e) {
      debugPrint('Error loading default address: $e');
    }
  }

  Future<void> _loadDefaultPaymentMethod() async {
    try {
      final paymentMethodService = getIt<PaymentMethodService>();
      await paymentMethodService.loadPaymentMethods();
      // Get the user's default/primary payment method from the service
      final defaultPaymentMethod = paymentMethodService.defaultPaymentMethod;

      // Check if a default payment method exists
      if (defaultPaymentMethod != null) {
        // Update state to select the default payment method by its ID
        setState(() {
          _selectedPaymentMethod = defaultPaymentMethod.id;
        });
      }
    } catch (e) {
      // Log error to console if payment method loading fails
      debugPrint('Error loading default payment method: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Return a Stepper widget that shows 3 sequential steps
    return Stepper(
      // Custom builder for the Continue and Back buttons at the bottom of each step
      controlsBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Call the onStepContinue callback when button is pressed
                  onPressed: details.onStepContinue,
                  child: Text(
                    // Show "Place order" on final step (step 1 = payment step), otherwise "Continue" => Now current step is 0 so the Continue button will be displayed
                    _currentStep == 2
                        ? AppTexts.placeOrderButton
                        : AppTexts.continueButton,
                    // Style the button text
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              // Conditionally show Back button only when not on first step
              // Will be true when moving to the next step as it will be 1
              if (_currentStep > 0) ...[
                const Gap(12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // Call the onStepCancel callback when button is pressed
                    onPressed: details.onStepCancel,
                    child: const Text(
                      AppTexts.backButton,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        );
      },
      // Callback when user clicks Back button to go to previous step
      onStepCancel: () {
        // Only allow going back if not on the first step
        if (_currentStep > 0) {
          // Update state to move to previous step
          setState(() {
            _currentStep -= 1;
          });
        }
      },
      // Callback when user clicks Continue button to move to next step
      onStepContinue: () async {
        // Check if we're not on the last step (step 2 is the last step)
        if (_currentStep < 2) {
          // Update state to move to next step
          setState(() {
            _currentStep += 1;
          });
        } else {
          // This is the final step (payment), so process order submission
          // Validate that the delivery information form is filled out correctly
          if (!_formKey.currentState!.validate()) {
            // If validation fails, return to the first step to let user fix errors
            setState(() {
              _currentStep = 0;
            });
            return;
          }
          // Validate that user has selected a payment method
          if (_selectedPaymentMethod == null) {
            // Show error snackbar if no payment method selected
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                // Set snackbar background to red for error
                backgroundColor: AppColors.red,
                // Display error message
                content: Center(
                  child: Text(
                    AppTexts.selectPaymentMethod,
                  ),
                ),
              ),
            );
            return;
          }
          // Ensure user is logged in so the order can be saved to Firestore
          if (FirebaseAuth.instance.currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.red,
                content: Center(
                  child: Text(AppTexts.pleaseLoginToPlaceOrder),
                ),
              ),
            );
            return;
          }
          // Show loading dialog while processing the order
          showDialog(
            // Prevent user from dismissing dialog by tapping outside
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.primary,
              ),
            ),
          );
          // Wrap order processing in try-catch to handle errors
          try {
            // Create a ShippingAddressModel from the form input values
            final shippingAddress = ShippingAddressModel(
              id: DateTime.now().toString(),
              name: _nameController.text,
              address: _addressController.text,
              city: _cityController.text,
              state: _stateController.text,
              zipcode: _zipCodeController.text,
              phone: _phoneController.text,
            );

            // Find the selected payment method from all available methods
            final paymentMethod =
                getIt<PaymentMethodService>().getPaymentMethods().firstWhere(
                      // Compare each method's ID with the selected payment method ID
                      (method) => method.id == _selectedPaymentMethod,
                    );

            // Transform cart items into order items
            final orderItems = widget.cartItems
                .map(
                  // For each cart item, create an OrderItemModel
                  (cartItem) => OrderItemModel(
                    // Add the product from the cart item
                    productModel: cartItem.product,
                    // Add the quantity from the cart item
                    quantity: cartItem.quantity,
                    // Add the unit price from the product
                    price: cartItem.product.price,
                  ),
                )
                .toList();

            // Calculate subtotal from the cart total (passed as parameter)
            final subtotal = widget.total;
            const shippingCost = 10.0;
            const discount = 0.0;
            final total = subtotal + shippingCost - discount;

            // Create the OrderModel with all order details
            final order = OrderModel(
              // Empty ID string, will be generated by backend
              id: '',
              orderItems: orderItems,
              orderDate: DateTime.now(),
              status: OrderStatusEnum.processing,
              subTotal: subtotal,
              shippingCost: shippingCost,
              discount: discount,
              total: total,
              shippingAddressModel: shippingAddress,
              // Payment method description for the receipt
              paymentMethod:
                  '${paymentMethod.cardType} ending in ${paymentMethod.cardNumber.substring(
                paymentMethod.cardNumber.length - 4,
              )}',
              // Estimated delivery date (5 days from now)
              estimatedDelivery: DateTime.now().add(
                const Duration(days: 5),
              ),
            );

            // Capture cubits before the async gap
            final ordersCubit = context.read<OrdersCubit>();
            final cartCubit = context.read<CartCubit>();

            // Add the order to the orders cubit (updates app state)
            await ordersCubit.addOrder(order);
            // Clear all items from the shopping cart
            cartCubit.clearCart();

            // Check if the widget context is still valid before updating UI
            if (context.mounted) {
              // Close the loading dialog
              Navigator.pop(context);
              // Show success dialog to confirm order was placed
              showDialog(
                context: context,
                // Build the success dialog
                builder: (context) => const OrderSubmissionDialog(),
              );
            }
          } catch (e) {
            // Check if the widget context is still valid before updating UI
            if (context.mounted) {
              // Close the loading dialog
              Navigator.pop(context);
              // Show error snackbar with the error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // Set snackbar background to red for error
                  backgroundColor: AppColors.red,
                  // Display error message with exception details
                  content: Center(
                    child: Text(
                      '${AppTexts.orderPlacedError} ${e.toString()}',
                    ),
                  ),
                ),
              );
            }
          }
        }
      },
      // Set which step is currently active/visible
      currentStep: _currentStep,
      steps: [
        // Step 0: Delivery Information
        Step(
          title: const Text(AppTexts.deliveryInformationStepTitle),
          content: DeliveryInformationStepContent(
            formKey: _formKey,
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
            addressController: _addressController,
            cityController: _cityController,
            stateController: _stateController,
            zipCodeController: _zipCodeController,
          ),
          // Step is active if current step is 0 or higher
          isActive: _currentStep >= 0,
          // Show checkmark if this step is complete (current step > 0)
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        // Step 1: Order Summary
        Step(
          title: const Text(
            AppTexts.orderSummaryStepTitle,
          ),
          content: OrderSummaryStepContent(
            // Pass the cart items to display in summary
            cartItems: widget.cartItems,
            // Pass the total price
            total: widget.total,
          ),
          // Step is active if current step is 1 or higher
          isActive: _currentStep >= 1,
          // Show checkmark if this step is complete (current step > 1)
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        // Step 2: Payment Method Selection
        Step(
          // Step title shown in the stepper header
          title: const Text(AppTexts.paymentMethods),
          // Step content - the payment method selection widget
          content: PaymentMethodStepContent(
            // Pass the currently selected payment method ID
            selectedPaymentMethod: _selectedPaymentMethod,
            // Pass callback function when user selects a payment method
            onPaymentMethodSelected: (paymentMethodId) {
              // Update state with the newly selected payment method
              setState(() {
                _selectedPaymentMethod = paymentMethodId;
              });
            },
          ),
          // Step is active if current step is 2 or higher
          isActive: _currentStep >= 2,
          // Show checkmark if this step is complete (current step > 2)
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
      ],
    );
  }
}
