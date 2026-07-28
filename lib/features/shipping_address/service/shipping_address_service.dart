import 'dart:convert';
import 'package:furniture/core/utils/app_texts.dart';
import 'package:furniture/features/orders/data/models/shipping_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ShippingAddressService {
  List<ShippingAddressModel> _addresses = [];
  final String _shippingAddressesKey = AppTexts.shippingAddressesKey;
  final _uuid = const Uuid();

  /// Returns all addresses currently stored in the _addresses list
  List<ShippingAddressModel> getAddresses() => _addresses;

  // Getter that returns the default address or null if no addresses exist
  ShippingAddressModel? get defaultAddress {
    // Check if the addresses list is empty and return null if true
    if (_addresses.isEmpty) return null;
    // Search for the first address where isDefault is true, otherwise return the first address
    return _addresses.firstWhere(
      (address) => address.isDefault,
      orElse: () => _addresses.first,
    );
  }

  /// Loads persisted addresses from SharedPreferences storage at app startup
  /// Should be called once from your Cubit's constructor or initialization method
  Future<void> loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the JSON string of addresses stored under the _shippingAddressesKey
    final storedAddresses = prefs.getString(_shippingAddressesKey);

    // Check if any stored addresses exist in SharedPreferences
    if (storedAddresses != null) {
      // Decode the JSON string into a Dart list of dynamic objects
      final List<dynamic> decodedAddresses = jsonDecode(storedAddresses);
      // Convert each decoded object to a ShippingAddressModel using fromJson constructor
      _addresses = decodedAddresses
          .map<ShippingAddressModel>(
              (order) => ShippingAddressModel.fromJson(order))
          .toList();
    } else {
      // If no stored addresses found, add sample addresses as defaults
      await _addSampleAddresses();
    }
  }

  /// Private method that creates and adds sample addresses when no stored addresses exist
  Future<void> _addSampleAddresses() async {
    // Create a list containing two sample ShippingAddressModel objects
    final sampleAddresses = [
      // First sample address: Home location marked as default
      ShippingAddressModel(
        id: _uuid.v4(),
        name: 'Home',
        address: '123 Main Street',
        city: 'New York',
        state: 'NY',
        zipcode: '1001',
        phone: '+1 (123) 456-789',
        // Mark this address as the default one
        isDefault: true,
      ),
      ShippingAddressModel(
        id: _uuid.v4(),
        name: 'Office',
        address: '456 Business Ave, Suite 200',
        city: 'New York',
        state: 'NY',
        zipcode: '1002',
        phone: '+1 (123) 456-7891',
        // isDefault not specified, defaults to false
      ),
    ];

    // Add all sample addresses to the in-memory _addresses list
    _addresses.addAll(sampleAddresses);
    await _saveAddresses();
  }

  /// Private method that converts addresses to JSON and persists them to SharedPreferences
  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert each ShippingAddressModel to JSON using toJson() method
    final String encodedAddresses = jsonEncode(
        _addresses.map((shippingAddress) => shippingAddress.toJson()).toList());
    // Store the JSON string in SharedPreferences under the _shippingAddressesKey
    await prefs.setString(_shippingAddressesKey, encodedAddresses);
  }

  /// Adds a new address to the list and persists it to storage
  Future<void> addAddress(ShippingAddressModel address) async {
    // Create a new address object with a generated UUID and all other fields from the input address
    final newAddress = address.copyWith(
      id: _uuid.v4(),
    );
    // Check if this is the first address being added or if it's marked as default
    if (_addresses.isEmpty || address.isDefault) {
      // Update all existing addresses to set isDefault to false
      _addresses =
          _addresses.map((addr) => addr.copyWith(isDefault: false)).toList();
    }
    // Add the new address to the in-memory list
    _addresses.add(newAddress);
    // Persist all addresses to SharedPreferences storage
    await _saveAddresses();
  }

  /// Updates an existing address in the list and persists the changes
  Future<void> updateAddress(ShippingAddressModel address) async {
    // Find the index position of the address with matching ID in the _addresses list
    final addressIndex = _addresses.indexWhere((addr) => addr.id == address.id);
    // Check if the address was found (indexWhere returns -1 if not found)
    if (addressIndex != -1) {
      // Check if the updated address is being set as the default address
      if (address.isDefault) {
        // Update all addresses: set the updated one as default, others as non-default
        _addresses = _addresses
            .map(
              (addr) => addr.id == address.id
                  ? address //return the address as it is
                  : addr.copyWith(isDefault: false),
            )
            .toList();
      } else {
        // Check if the address being updated was previously the default address
        if (_addresses[addressIndex].isDefault &&
            // AND it's being changed to non-default
            !address.isDefault &&
            // AND there are other addresses in the list
            _addresses.length > 1) {
          // Find another address that is not the current one to make it default
          final newDefault =
              _addresses.firstWhere((addr) => addr.id != address.id);
          // Get the index of the new default address
          final newDefaultIndex = _addresses.indexOf(newDefault);
          // Update the new default address to have isDefault true
          _addresses[newDefaultIndex] = newDefault.copyWith(isDefault: true);
        }
        // Update the address at the found index with the new address data
        _addresses[addressIndex] = address;
      }

      // Persist all changes to SharedPreferences storage
      await _saveAddresses();
    }
  }

  /// Deletes an address by ID and ensures there's always a default address
  Future<void> deleteAddress(String id) async {
    // Find the index of the address with the matching ID
    final index = _addresses.indexWhere((addr) => addr.id == id);
    // Check if the address was found
    if (index != -1) {
      // Store whether the address being deleted was marked as default
      final wasDefault = _addresses[index].isDefault;
      // Remove the address from the list at the found index
      _addresses.removeAt(index);

      // Check if the deleted address was default AND there are still addresses remaining
      if (wasDefault && _addresses.isEmpty) {
        // Set the first address in the list as the new default address
        _addresses[0] = _addresses[0].copyWith(isDefault: true);
      }
    }
    // Persist all changes to SharedPreferences storage
    await _saveAddresses();
  }

  /// Sets a specific address as the default address by its ID
  Future<void> setDefaultAddress(String id) async {
    // Find the index of the address with the matching ID
    final index = _addresses.indexWhere((addr) => addr.id == id);
    // Check if the address was found
    if (index != -1) {
      // Map through all addresses: set the matched one as default, others as non-default
      _addresses = _addresses
          .map(
            (addr) => addr.id == id
                ? addr.copyWith(isDefault: true)
                : addr.copyWith(isDefault: false),
          )
          .toList();

      // Persist all changes to SharedPreferences storage
      await _saveAddresses();
    }
  }
}
