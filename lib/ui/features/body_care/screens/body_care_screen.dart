import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/body_care_bloc.dart';
import '../widgets/body_service_list.dart';

class BodyCareScreen extends StatelessWidget {
  const BodyCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_body_service');
        },
        backgroundColor: Colors.blue[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<BodyCareBloc, BodyCareState>(
        builder: (context, state) {
          if (state is BodyCareLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BodyCareError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BodyCareBloc>().add(LoadBodyServices());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else if (state is BodyCareLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://avatars.mds.yandex.net/get-ydo/3927445/2a00000180bd9555624724006a173c0f80bd/diploma',
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
                    child: BodyServiceList(
                      services: state.services,
                      selectedService: state.selectedIndex,
                      onSelectService: (index) {
                        context.read<BodyCareBloc>().add(SelectBodyService(index));
                      },
                      onDeleteService: (index) {
                        context.read<BodyCareBloc>().add(DeleteBodyService(state.services[index].id));
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


