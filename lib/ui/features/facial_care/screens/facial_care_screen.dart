import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/facial_care_bloc.dart';
import '../widgets/facial_service_list.dart';

class FacialCareScreen extends StatelessWidget {
  const FacialCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_facial_service');
        },
        backgroundColor: Colors.pink[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<FacialCareBloc, FacialCareState>(
        builder: (context, state) {
          if (state is FacialCareLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FacialCareError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FacialCareBloc>().add(LoadFacialServices());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else if (state is FacialCareLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://100kupon.ru/assets/images/products/6436/uploads-zlavadna-sk-deal-images-2020-0821-5f3fb6950da6b.jpg',
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
                    child: FacialServiceList(
                      services: state.services,
                      selectedService: state.selectedIndex,
                      onSelectService: (index) {
                        context.read<FacialCareBloc>().add(SelectFacialService(index));
                      },
                      onDeleteService: (index) {
                        context.read<FacialCareBloc>().add(DeleteFacialService(state.services[index].id));
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

