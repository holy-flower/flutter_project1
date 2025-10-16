class FacialService {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String description;
  final String details;
  final List<String> effects;

  FacialService({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.details,
    required this.effects,
  });

  FacialService copyWith({
    String? id,
    String? title,
    String? duration,
    String? price,
    String? description,
    String? details,
    List<String>? effects,
  }) {
    return FacialService(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      description: description ?? this.description,
      details: details ?? this.details,
      effects: effects ?? this.effects,
    );
  }
}