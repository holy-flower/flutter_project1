import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/spa_bloc.dart';
import '../widgets/program_selector.dart';
import '../widgets/program_details.dart';

class SpaScreen extends StatelessWidget {
  const SpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_spa_service');
        },
        backgroundColor: Colors.purple[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: BlocBuilder<SpaBloc, SpaState>(
          builder: (context, state) {
            if (state is SpaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SpaError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ошибка: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SpaBloc>().add(LoadSpaServices());
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            } else if (state is SpaLoaded) {
              if (state.services.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.spa, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Нет программ', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                );
              }
              final selectedIndex = state.selectedIndex >= 0 && state.selectedIndex < state.services.length
                  ? state.selectedIndex
                  : 0;
              return Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: 'http://dental0c.beget.tech/wp-content/uploads/2024/12/1234.jpg',
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
                  ),
                  const SizedBox(height: 10),
                  ProgramSelector(
                    programs: state.services,
                    selectedProgram: selectedIndex,
                    onSelectProgram: (index) {
                      context.read<SpaBloc>().add(SelectSpaService(index));
                    },
                    onDeleteProgram: (index) {
                      context.read<SpaBloc>().add(DeleteSpaService(state.services[index].id));
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ProgramDetails(
                        program: state.services[selectedIndex],
                        onBookProgram: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Программа забронирована'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Загрузка программ...'));
            }
          },
        ),
      ),
    );
  }
}

