class Settings {
  final String siteName;
  final String language;
  final Map<String, double> weights;
  final List<String> paymentMethods;
  final String primaryColor;

  Settings({
    required this.siteName,
    required this.language,
    required this.weights,
    required this.paymentMethods,
    required this.primaryColor,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      siteName: json['siteName'],
      language: json['language'],
      weights: Map<String, double>.from(json['weights']),
      paymentMethods: List<String>.from(json['paymentMethods']),
      primaryColor: json['primaryColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siteName': siteName,
      'language': language,
      'weights': weights,
      'paymentMethods': paymentMethods,
      'primaryColor': primaryColor,
    };
  }
}

