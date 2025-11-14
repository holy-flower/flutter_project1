import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Ошибка загрузки',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadProfile());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileLoaded) {
              return _buildProfileContent(context, state.profile);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Загрузка профиля...'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadProfile());
                      },
                      child: const Text('Загрузить профиль'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Profile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showEditImageDialog(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profile.avatarUrl != null
                      ? NetworkImage(profile.avatarUrl!)
                      : null,
                  child: profile.avatarUrl == null
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            profile.position,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(profile.experience, 'Опыт работы'),
              _buildStatItem(profile.clientsCount, 'Клиентов'),
              _buildStatItem(profile.rating, 'Рейтинг'),
            ],
          ),
          const SizedBox(height: 24),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Специализация',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18, color: Colors.pink),
                        onPressed: () => _showEditSpecialtiesDialog(context, profile),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...profile.specialties.map((specialty) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Icon(Icons.circle, size: 8, color: Colors.pink[300]),
                            const SizedBox(width: 8),
                            Expanded(child: Text(specialty)),
                          ],
                        ),
                      )
                  ).toList(),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Контактная информация',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18, color: Colors.pink),
                        onPressed: () => _showEditContactsDialog(context, profile),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.phone, profile.phone),
                  const SizedBox(height: 10),
                  _buildContactItem(Icons.email, profile.email),
                  const SizedBox(height: 10),
                  _buildContactItem(Icons.access_time, profile.schedule),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showEditProfileDialog(context, profile),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Редактировать профиль'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            shape: BoxShape.circle,
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.pink),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, Profile profile) {
    TextEditingController nameController = TextEditingController(text: profile.name);
    TextEditingController positionController = TextEditingController(text: profile.position);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать профиль'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Имя и фамилия',
                    border: OutlineInputBorder(),
                  ),
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Должность',
                    border: OutlineInputBorder(),
                  ),
                  controller: positionController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && positionController.text.isNotEmpty) {
                  context.read<ProfileBloc>().add(UpdateProfile(
                    name: nameController.text,
                    position: positionController.text,
                  ));
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Профиль успешно обновлен'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Заполните все поля'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactsDialog(BuildContext context, Profile profile) {
    TextEditingController phoneController = TextEditingController(text: profile.phone);
    TextEditingController emailController = TextEditingController(text: profile.email);
    TextEditingController scheduleController = TextEditingController(text: profile.schedule);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать контакты'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Телефон',
                    border: OutlineInputBorder(),
                  ),
                  controller: phoneController,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'График работы',
                    border: OutlineInputBorder(),
                  ),
                  controller: scheduleController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (phoneController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    scheduleController.text.isNotEmpty) {
                  context.read<ProfileBloc>().add(UpdateProfile(
                    phone: phoneController.text,
                    email: emailController.text,
                    schedule: scheduleController.text,
                  ));
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Контакты успешно обновлены'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Заполните все поля'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showEditSpecialtiesDialog(BuildContext context, Profile profile) {
    TextEditingController specialtyController = TextEditingController();
    List<String> specialties = List.from(profile.specialties);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Редактировать специализации'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Новая специализация',
                              border: OutlineInputBorder(),
                            ),
                            controller: specialtyController,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.pink),
                          onPressed: () {
                            if (specialtyController.text.isNotEmpty) {
                              setState(() {
                                specialties.add(specialtyController.text);
                                specialtyController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Текущие специализации:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...specialties.asMap().entries.map((entry) =>
                        ListTile(
                          leading: Icon(Icons.circle, size: 8, color: Colors.pink[300]),
                          title: Text(entry.value),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red, size: 18),
                            onPressed: () {
                              setState(() {
                                specialties.removeAt(entry.key);
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.zero,
                        )
                    ).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(UpdateProfile(
                      specialties: specialties,
                    ));
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Специализации обновлены'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Сменить фото профиля'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.camera_alt, size: 48, color: Colors.pink),
              SizedBox(height: 16),
              Text('Функция смены фото будет доступна в следующем обновлении'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}