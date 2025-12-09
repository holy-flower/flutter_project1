import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/hair_removal_bloc.dart';
import '../widgets/service_selector.dart';
import '../widgets/service_details.dart';

class HairRemovalScreen extends StatelessWidget {
  const HairRemovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_hair_removal_service');
        },
        backgroundColor: Colors.orange[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<HairRemovalBloc, HairRemovalState>(
        builder: (context, state) {
          if (state is HairRemovalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HairRemovalError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HairRemovalBloc>().add(LoadHairRemovalServices());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else if (state is HairRemovalLoaded) {
            if (state.services.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.content_cut, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Нет услуг', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              );
            }
            final selectedIndex = state.selectedIndex >= 0 && state.selectedIndex < state.services.length
                ? state.selectedIndex
                : 0;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://ak.picdn.net/shutterstock/videos/1093975795/thumb/1.jpg',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ServiceSelector(
                    services: state.services,
                    selectedService: selectedIndex,
                    onSelectService: (index) {
                      context.read<HairRemovalBloc>().add(SelectHairRemovalService(index));
                    },
                    onDeleteService: (index) {
                      context.read<HairRemovalBloc>().add(DeleteHairRemovalService(state.services[index].id));
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ServiceDetails(
                        service: state.services[selectedIndex],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Загрузка услуг...'));
          }
        },
      ),
    );
  }
}

