class PromoCodeModel {
  final String code;
  final String discount;
  final String description;
  final DateTime validateUntil;
  final bool isPercentage;
  final bool isUsed;

  PromoCodeModel({
    required this.code,
    required this.discount,
    required this.description,
    required this.validateUntil,
    this.isPercentage = false,
    this.isUsed = false,
  });

  PromoCodeModel promoCodeModelCopy({
    String? code,
    String? discount,
    String? description,
    DateTime? validateUntil,
    bool? isPercentage,
    bool? isUsed,
  }) {
    return PromoCodeModel(
      code: code ?? this.code,
      discount: discount ?? this.discount,
      description: description ?? this.description,
      validateUntil: validateUntil ?? this.validateUntil,
      isPercentage: isPercentage ?? this.isPercentage,
      isUsed: isUsed ?? this.isUsed,
    );
  }

  bool get isExpired => DateTime.now().isAfter(validateUntil);

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount': discount,
      'description': description,
      'validateUntil': validateUntil.toIso8601String(),
      'isPercentage': isPercentage,
      'isUsed': isUsed,
    };
  }

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      code: json['code'],
      discount: json['discount'],
      description: json['description'],
      validateUntil: DateTime.parse(json['validateUntil']),
      isPercentage: json['isPercentage'],
      isUsed: json['isUsed'],
    );
  }
}
