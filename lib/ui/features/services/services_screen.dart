import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/services_bloc.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Загружаем услуги при первом открытии экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<ServicesBloc>().state is ServicesInitial) {
        context.read<ServicesBloc>().add(LoadServices());
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Категории услуг',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildFilterSection(context),
            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<ServicesBloc, ServicesState>(
                builder: (context, state) {
                  if (state is ServicesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ServicesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ServicesBloc>().add(LoadServices());
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ServicesLoaded) {
                    return _buildServicesList(context, state.filteredServices);
                  } else {
                    return const Center(child: Text('Загрузка услуг...'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        final isSearching = state is ServicesLoaded &&
            (context.read<ServicesBloc>().state as ServicesLoaded).filteredServices.length !=
                (context.read<ServicesBloc>().state as ServicesLoaded).services.length;

        return Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onChanged: (query) {
                    if (query.isNotEmpty) {
                      context.read<ServicesBloc>().add(FilterServices(
                        filter: ServiceFilter.search,
                        searchQuery: query,
                      ));
                    } else {
                      context.read<ServicesBloc>().add(FilterServices(
                        filter: ServiceFilter.all,
                      ));
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Поиск услуг...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: isSearching ? IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        context.read<ServicesBloc>().add(FilterServices(
                          filter: ServiceFilter.all,
                        ));
                      },
                    ) : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            PopupMenuButton<ServiceFilter>(
              icon: const Icon(Icons.filter_list),
              onSelected: (filter) {
                context.read<ServicesBloc>().add(FilterServices(filter: filter));
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: ServiceFilter.all,
                  child: Text('Все услуги'),
                ),
                const PopupMenuItem(
                  value: ServiceFilter.popular,
                  child: Text('Популярные'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildServicesList(BuildContext context, List<ServiceCategoryUI> services) {
    if (services.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Услуги не найдены',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                service.icon,
                color: service.color,
                size: 24,
              ),
            ),
            title: Row(
              children: [
                Text(
                  service.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (service.isPopular) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Популярная',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.description),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${service.serviceCount} услуг',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'от ${service.totalPrice} ₽',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.read<ServicesBloc>().add(UpdateServiceStats(
                categoryTitle: service.title,
                price: 1000,
              ));
              context.push(service.route);
            },
          ),
        );
      },
    );
  }
}


