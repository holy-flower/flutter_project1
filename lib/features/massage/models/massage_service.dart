class MassageService {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String description;
  final String indication;
  final String details;
  final List<String> techniques;
  final List<String> benefits;

  MassageService({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.indication,
    required this.details,
    required this.techniques,
    required this.benefits,
  });

  MassageService copyWith({
    String? id,
    String? title,
    String? duration,
    String? price,
    String? description,
    String? indication,
    String? details,
    List<String>? techniques,
    List<String>? benefits,
  }) {
    return MassageService(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      description: description ?? this.description,
      indication: indication ?? this.indication,
      details: details ?? this.details,
      techniques: techniques ?? this.techniques,
      benefits: benefits ?? this.benefits,
    );
  }
}