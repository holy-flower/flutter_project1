class ServiceCategory {
  final String id;
  final String title;
  final String route;
  final String description;
  final int serviceCount;
  final int totalPrice;
  final bool isPopular;

  const ServiceCategory({
    required this.id,
    required this.title,
    required this.route,
    required this.description,
    required this.serviceCount,
    required this.totalPrice,
    required this.isPopular,
  });

  ServiceCategory copyWith({
    String? id,
    String? title,
    String? route,
    String? description,
    int? serviceCount,
    int? totalPrice,
    bool? isPopular,
  }) {
    return ServiceCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      route: route ?? this.route,
      description: description ?? this.description,
      serviceCount: serviceCount ?? this.serviceCount,
      totalPrice: totalPrice ?? this.totalPrice,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}


