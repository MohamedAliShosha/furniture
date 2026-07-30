class PaymentMethodModel {
  final String id;
  final String cardType;
  final String cardNumber;
  final String expireDate;
  final String cardHolderName;
  final bool isDefault;
  final String cardColors;

  PaymentMethodModel({
    required this.id,
    required this.cardType,
    required this.cardNumber,
    required this.expireDate,
    required this.cardHolderName,
    required this.isDefault,
    required this.cardColors,
  });

  PaymentMethodModel paymentMethodModelCopy({
    String? id,
    String? cardType,
    String? cardNumber,
    String? expireDate,
    String? cardHolderName,
    bool? isDefault,
    String? cardColors,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      cardType: cardType ?? this.cardType,
      cardNumber: cardNumber ?? this.cardNumber,
      expireDate: expireDate ?? this.expireDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      isDefault: isDefault ?? this.isDefault,
      cardColors: cardColors ?? this.cardColors,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardType': cardType,
      'cardNumber': cardNumber,
      'expireDate': expireDate,
      'cardHolderName': cardHolderName,
      'isDefault': isDefault,
      'cardColors': cardColors,
    };
  }

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      cardType: json['cardType'],
      cardNumber: json['cardNumber'],
      expireDate: json['expireDate'],
      cardHolderName: json['cardHolderName'],
      isDefault: json['isDefault'],
      cardColors: json['cardColors'],
    );
  }
}
