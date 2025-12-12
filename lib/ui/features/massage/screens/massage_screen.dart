import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/massage_bloc.dart';
import '../widgets/massage_list.dart';

class MassageScreen extends StatelessWidget {
  const MassageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_massage_service');
        },
        backgroundColor: Colors.green[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<MassageBloc, MassageState>(
        builder: (context, state) {
          if (state is MassageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MassageError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MassageBloc>().add(LoadMassageServices());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else if (state is MassageLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://avatars.mds.yandex.net/get-altay/367512/2a0000015b861eefde2b7a30525f34bd1031/orig',
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
                  Expanded(
                    child: MassageList(
                      massages: state.services,
                      selectedMassage: state.selectedIndex,
                      onSelectMassage: (index) {
                        context.read<MassageBloc>().add(SelectMassageService(index));
                      },
                      onDeleteMassage: (index) {
                        context.read<MassageBloc>().add(DeleteMassageService(state.services[index].id));
                      },
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





