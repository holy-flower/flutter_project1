class Profile {
  final String id;
  final String name;
  final String position;
  final String experience;
  final String clientsCount;
  final String rating;
  final List<String> specialties;
  final String phone;
  final String email;
  final String schedule;
  final String? avatarUrl;

  const Profile({
    required this.id,
    required this.name,
    required this.position,
    required this.experience,
    required this.clientsCount,
    required this.rating,
    required this.specialties,
    required this.phone,
    required this.email,
    required this.schedule,
    this.avatarUrl,
  });

  Profile copyWith({
    String? id,
    String? name,
    String? position,
    String? experience,
    String? clientsCount,
    String? rating,
    List<String>? specialties,
    String? phone,
    String? email,
    String? schedule,
    String? avatarUrl,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      experience: experience ?? this.experience,
      clientsCount: clientsCount ?? this.clientsCount,
      rating: rating ?? this.rating,
      specialties: specialties ?? this.specialties,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      schedule: schedule ?? this.schedule,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}


