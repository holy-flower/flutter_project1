import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cosmetology_news_bloc.dart';
import '../../../../core/di/injection_container.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CosmetologyNewsBloc>()..add(SearchCosmetologyNewsEvent()),
      child: const NewsListView(),
    );
  }
}

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NewsListViewContent();
  }
}

class _NewsListViewContent extends StatefulWidget {
  const _NewsListViewContent();

  @override
  State<_NewsListViewContent> createState() => _NewsListViewContentState();
}

class _NewsListViewContentState extends State<_NewsListViewContent> {
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, String label) async {
    // NewsAPI бесплатный тариф ограничен последним месяцем
    final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7)), // По умолчанию неделю назад
      firstDate: oneMonthAgo, // Не раньше месяца назад
      lastDate: DateTime.now(),
      helpText: 'Выберите дату (доступны только последние 30 дней)',
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T')[0]; // Формат YYYY-MM-DD
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости косметологии'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CosmetologyNewsBloc>().add(SearchCosmetologyNewsEvent());
                        },
                        child: const Text('Косметология'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CosmetologyNewsBloc>().add(GetSkincareNewsEvent());
                        },
                        child: const Text('Уход за кожей'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CosmetologyNewsBloc>().add(GetTopBeautyNewsEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[100],
                        ),
                        child: const Text('Топ новостей'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CosmetologyNewsBloc>().add(GetHealthNewsSourcesEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[100],
                        ),
                        child: const Text('Источники'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Card(
                  color: Colors.orange[50],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline, size: 18, color: Colors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Поиск новостей по датам:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Бесплатный тариф: доступны только последние 30 дней',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Быстрые кнопки для выбора дат
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  final now = DateTime.now();
                                  final weekAgo = now.subtract(const Duration(days: 7));
                                  _fromDateController.text = weekAgo.toIso8601String().split('T')[0];
                                  _toDateController.text = now.toIso8601String().split('T')[0];
                                },
                                icon: const Icon(Icons.today, size: 16),
                                label: const Text('Неделя', style: TextStyle(fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  final now = DateTime.now();
                                  final monthAgo = now.subtract(const Duration(days: 30));
                                  _fromDateController.text = monthAgo.toIso8601String().split('T')[0];
                                  _toDateController.text = now.toIso8601String().split('T')[0];
                                },
                                icon: const Icon(Icons.calendar_month, size: 16),
                                label: const Text('Месяц', style: TextStyle(fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _fromDateController,
                                decoration: const InputDecoration(
                                  labelText: 'От (YYYY-MM-DD)',
                                  border: OutlineInputBorder(),
                                  hintText: '2024-01-01',
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context, _fromDateController, 'От'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _toDateController,
                                decoration: const InputDecoration(
                                  labelText: 'До (YYYY-MM-DD)',
                                  border: OutlineInputBorder(),
                                  hintText: '2024-01-31',
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context, _toDateController, 'До'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_fromDateController.text.isNotEmpty && _toDateController.text.isNotEmpty) {
                              context.read<CosmetologyNewsBloc>().add(
                                    GetCosmeticsNewsByDateEvent(
                                      _fromDateController.text,
                                      _toDateController.text,
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Пожалуйста, выберите обе даты'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[200],
                          ),
                          child: const Text('Найти новости за период'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CosmetologyNewsBloc, CosmetologyNewsState>(
              builder: (context, state) {
                if (state is CosmetologyNewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CosmetologyNewsError) {
                  return Center(
                    child: Text(
                      'Ошибка: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is CosmetologyNewsLoaded) {
                  if (state.newsResponse.articles.isEmpty) {
                    return const Center(child: Text('Новости не найдены'));
                  }
                  return ListView.builder(
                    itemCount: state.newsResponse.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.newsResponse.articles[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(article.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (article.description.isNotEmpty)
                                Text(article.description),
                              const SizedBox(height: 4),
                              Text(
                                article.sourceName,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () {
                            if (article.url.isNotEmpty) {
                              // Можно открыть в браузере
                            }
                          },
                        ),
                      );
                    },
                  );
                }
                if (state is CosmetologyNewsSourcesLoaded) {
                  if (state.sourcesResponse.sources.isEmpty) {
                    return const Center(child: Text('Источники новостей не найдены'));
                  }
                  return ListView.builder(
                    itemCount: state.sourcesResponse.sources.length,
                    itemBuilder: (context, index) {
                      final source = state.sourcesResponse.sources[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.source, color: Colors.teal),
                          title: Text(source.name),
                          subtitle: Text('ID: ${source.id}'),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

