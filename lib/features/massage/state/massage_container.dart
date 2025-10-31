import 'package:flutter/material.dart';
import '../models/massage_service.dart';
import '../screens/massage_screen.dart';
import '../screens/add_massage_service_screen.dart';

class MassageContainer extends StatefulWidget {
  const MassageContainer({super.key});

  @override
  State<MassageContainer> createState() => _MassageContainerState();
}

class _MassageContainerState extends State<MassageContainer> {
  int _selectedMassage = -1;
  final List<MassageService> _massages = [
    MassageService(
      id: '1',
      title: 'Классический массаж',
      duration: '60 мин',
      price: '3000 ₽',
      description: 'Расслабляющий массаж всего тела для снятия напряжения и стресса',
      indication: 'Стресс, усталость, мышечное напряжение',
      details: 'Традиционный массаж, направленный на расслабление мышц, снятие напряжения и улучшение общего состояния. Включает техники поглаживания, разминания и растирания. Подходит для всех возрастных групп.',
      techniques: ['Поглаживание', 'Разминание', 'Растирание', 'Вибрация', 'Выжимание'],
      benefits: ['Снятие мышечного напряжения', 'Улучшение кровообращения', 'Расслабление нервной системы', 'Повышение эластичности мышц'],
    ),
    MassageService(
      id: '2',
      title: 'Антицеллюлитный массаж',
      duration: '45 мин',
      price: '3500 ₽',
      description: 'Интенсивная проработка проблемных зон для коррекции фигуры',
      indication: 'Целлюлит, дряблость кожи, локальные жировые отложения',
      details: 'Специализированный массаж, направленный на борьбу с целлюлитом и улучшение контуров тела. Используются интенсивные техники для разрушения жировых отложений и стимуляции лимфотока.',
      techniques: ['Глубокое разминание', 'Вакуумный массаж', 'Ручной лимфодренаж', 'Разминание проблемных зон'],
      benefits: ['Уменьшение целлюлита', 'Улучшение тонуса кожи', 'Коррекция фигуры', 'Ускорение метаболизма'],
    ),
    MassageService(
      id: '3',
      title: 'Лимфодренажный массаж',
      duration: '50 мин',
      price: '4000 ₽',
      description: 'Техника для выведения лишней жидкости и токсинов из организма',
      indication: 'Отеки, нарушение лимфотока, детокс',
      details: 'Щадящий массаж, стимулирующий лимфатическую систему. Способствует выведению токсинов, уменьшению отеков и улучшению обмена веществ. Особенно эффективен после операций.',
      techniques: ['Легкие надавливания', 'Круговые движения', 'Направленный лимфоток', 'Поверхностные поглаживания'],
      benefits: ['Уменьшение отеков', 'Выведение токсинов', 'Улучшение лимфотока', 'Укрепление иммунитета'],
    ),
    MassageService(
      id: '4',
      title: 'SPA-массаж',
      duration: '75 мин',
      price: '5000 ₽',
      description: 'Комплексный релакс с ароматерапией и расслабляющей атмосферой',
      indication: 'Глубокий релакс, восстановление, гармония',
      details: 'Премиальный массаж с использованием ароматических масел и расслабляющей музыки. Сочетает различные техники для достижения глубокого релакса и восстановления энергетического баланса.',
      techniques: ['Ароматерапия', 'Комбинированные техники', 'Энергетический баланс', 'Работа с дыханием'],
      benefits: ['Глубокое расслабление', 'Восстановление энергии', 'Гармония тела и духа', 'Улучшение качества сна'],
    ),
    MassageService(
      id: '5',
      title: 'Спортивный массаж',
      duration: '55 мин',
      price: '3200 ₽',
      description: 'Специализированный массаж для спортсменов и активных людей',
      indication: 'Мышечное восстановление, подготовка к нагрузкам',
      details: 'Интенсивный массаж, направленный на подготовку мышц к физическим нагрузкам или восстановление после тренировок. Увеличивает гибкость и предотвращает травмы.',
      techniques: ['Глубокий массаж тканей', 'Растяжка', 'Точечное воздействие', 'Разминание мышц'],
      benefits: ['Ускорение восстановления', 'Улучшение гибкости', 'Профилактика травм', 'Повышение выносливости'],
    ),
  ];

  void _selectMassage(int index) {
    setState(() {
      _selectedMassage = _selectedMassage == index ? -1 : index;
    });
  }

  void _deleteMassage(int index) {
    final removedMassage = _massages[index];
    final removedIndex = index;

    setState(() {
      _massages.removeAt(index);
      if (_selectedMassage == index) {
        _selectedMassage = -1;
      } else if (_selectedMassage > index) {
        _selectedMassage--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Массаж "${removedMassage.title}" удален'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _massages.insert(removedIndex, removedMassage);
              if (_selectedMassage >= removedIndex) {
                _selectedMassage++;
              }
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToAddMassage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddMassageServiceScreen(
                onMassageAdded: _addMassage,
            )
        )
    );
  }

  void _addMassage(MassageService newMassage) {
    setState(() {
      _massages.add(newMassage);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Массаж "${newMassage.title}" добавлен'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MassageScreen(
      massages: _massages,
      selectedMassage: _selectedMassage,
      onSelectMassage: _selectMassage,
      onDeleteMassage: _deleteMassage,
      onAddMassage: _navigateToAddMassage,
    );
  }
}