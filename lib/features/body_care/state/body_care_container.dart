import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/body_service.dart';
import '../screens/body_care_screen.dart';
import '../screens/add_body_service_screen.dart';

class BodyCareContainer extends StatefulWidget {
  final List<BodyService> initialServices;

  const BodyCareContainer({
    super.key,
    this.initialServices = const [],
  });

  static Widget withServices(List<BodyService> services) {
    return BodyCareContainer(initialServices: services);
  }

  @override
  State<BodyCareContainer> createState() => _BodyCareContainerState();
}

class _BodyCareContainerState extends State<BodyCareContainer> {
  int _selectedService = -1;
  late List<BodyService> _services;

  @override
  void initState() {
    super.initState();
    _services = widget.initialServices.isNotEmpty ? List.from(widget.initialServices)
        : [
      BodyService(
        id: '1',
        title: 'Обертывание',
        price: '4000 ₽',
        duration: '60 мин',
        description: 'Комплексное обертывание для коррекции фигуры',
        features: ['Водорослевое', 'Шоколадное', 'Медовое'],
        details: 'Процедура обертывания с использованием натуральных компонентов. Способствует уменьшению объемов, выведению токсинов и улучшению состояния кожи. Проводится с применением профессиональной косметики премиум-класса.',
        effects: ['Коррекция фигуры', 'Выведение токсинов', 'Улучшение тонуса кожи', 'Снижение отечности'],
      ),
      BodyService(
        id: '2',
        title: 'Скрабирование',
        price: '2500 ₽',
        duration: '45 мин',
        description: 'Глубокое очищение и обновление кожи тела',
        features: ['Кофейный скраб', 'Соляной скраб', 'Сахарный скраб'],
        details: 'Процедура эксфолиации для удаления омертвевших клеток кожи. Стимулирует кровообращение и подготавливает кожу к последующему уходу. Подбирается индивидуально под тип кожи.',
        effects: ['Очищение кожи', 'Стимуляция кровообращения', 'Обновление клеток', 'Улучшение текстуры кожи'],
      ),
      BodyService(
        id: '3',
        title: 'Антицеллюлит',
        price: '5000 ₽',
        duration: '75 мин',
        description: 'Комплексная программа против целлюлита',
        features: ['Массаж', 'Обертывание', 'Скрабирование'],
        details: 'Интенсивная программа, сочетающая несколько методик для эффективной борьбы с целлюлитом. Включает массаж, обертывание и скрабирование. Курс из 10 процедур дает максимальный эффект.',
        effects: ['Уменьшение целлюлита', 'Улучшение лимфотока', 'Подтяжка кожи', 'Уменьшение объемов'],
      ),
      BodyService(
        id: '4',
        title: 'Увлажнение',
        price: '3000 ₽',
        duration: '50 мин',
        description: 'Интенсивное увлажнение и питание кожи тела',
        features: ['Интенсивное', 'Питательное', 'Восстанавливающее'],
        details: 'Процедура глубокого увлажнения с использованием профессиональной косметики. Восстанавливает гидролипидный баланс и улучшает эластичность кожи. Идеально подходит для сухой и обезвоженной кожи.',
        effects: ['Глубокое увлажнение', 'Восстановление баланса', 'Улучшение эластичности', 'Снятие раздражения'],
      ),
      BodyService(
        id: '5',
        title: 'Детокс',
        price: '3500 ₽',
        duration: '55 мин',
        description: 'Очищение организма от токсинов',
        features: ['Лимфодренаж', 'Обертывание', 'Ароматерапия'],
        details: 'Комплексная детокс-программа для очищения организма от шлаков и токсинов. Способствует улучшению обмена веществ и общего самочувствия.',
        effects: ['Очищение от токсинов', 'Улучшение метаболизма', 'Снижение отеков', 'Повышение энергии'],
      ),
      BodyService(
        id: '6',
        title: 'Лифтинг',
        price: '4500 ₽',
        duration: '65 мин',
        description: 'Подтяжка и упругость кожи тела',
        features: ['Лифтинг-массаж', 'Обертывание', 'Аппаратная методика'],
        details: 'Процедура направлена на подтяжку кожи, улучшение ее упругости и эластичности. Особенно эффективна для зон, подверженных возрастным изменениям.',
        effects: ['Подтяжка кожи', 'Улучшение контуров', 'Повышение упругости', 'Борьба с дряблостью'],
      ),
      BodyService(
        id: '7',
        title: 'SPA-ритуал',
        price: '6000 ₽',
        duration: '90 мин',
        description: 'Комплексный уход за телом премиум-класса',
        features: ['Скрабирование', 'Обертывание', 'Массаж', 'Ароматерапия'],
        details: 'Эксклюзивный SPA-ритуал, сочетающий в себе лучшие процедуры по уходу за телом. Полное расслабление и преображение за одну процедуру.',
        effects: ['Глубокое расслабление', 'Комплексное омоложение', 'Восстановление кожи', 'Эмоциональная гармония'],
      ),
      BodyService(
        id: '8',
        title: 'Антистресс',
        price: '3200 ₽',
        duration: '50 мин',
        description: 'Расслабляющая процедура для снятия напряжения',
        features: ['Расслабляющий массаж', 'Ароматерапия', 'Музыкотерапия'],
        details: 'Специально разработанная процедура для снятия стресса и мышечного напряжения. Восстанавливает психоэмоциональное равновесие.',
        effects: ['Снятие стресса', 'Расслабление мышц', 'Улучшение сна', 'Восстановление энергии'],
      ),
    ];
  }

  void _selectService(int index) {
    setState(() {
      _selectedService = _selectedService == index ? -1 : index;
    });
  }

  void _deleteService(int index) {
    final removedService = _services[index];
    final removedIndex = index;

    setState(() {
      _services.removeAt(index);
      if (_selectedService == index) {
        _selectedService = -1;
      } else if (_selectedService > index) {
        _selectedService--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Услуга "${removedService.title}" удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _services.insert(removedIndex, removedService);
              if (_selectedService >= removedIndex) {
                _selectedService++;
              }
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateAddToService() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddBodyServiceScreen(
              onServiceAdded: _addService,
              currentServices: _services,
            ),
        ),
    );
  }

  void _addService(BodyService newService) {
    setState(() {
      _services.add(newService);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Услуга "${newService.title}" добавлена'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyCareScreen(
      services: _services,
      selectedService: _selectedService,
      onSelectService: (int index) => _selectService(index),
      onDeleteService: (int index) => _deleteService(index),
      onAddService: () => _navigateAddToService(),
    );
  }
}