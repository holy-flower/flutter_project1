class BodyService {
  final String id;
  final String title;
  final String price;
  final String duration;
  final String description;
  final List<String> features;
  final String details;
  final List<String> effects;

  BodyService({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.description,
    required this.features,
    required this.details,
    required this.effects,
  });

  BodyService copyWith({
    String? id,
    String? title,
    String? price,
    String? duration,
    String? description,
    List<String>? features,
    String? details,
    List<String>? effects,
  }) {
    return BodyService(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      features: features ?? this.features,
      details: details ?? this.details,
      effects: effects ?? this.effects,
    );
  }
}