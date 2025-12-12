class InventoryItem {
  final String id;
  final String name;
  final String category;
  final int currentStock;
  final int minStock;
  final String unit;
  final int cost;
  final String supplier;
  final DateTime lastRestock;
  final DateTime expiryDate;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.currentStock,
    required this.minStock,
    required this.unit,
    required this.cost,
    required this.supplier,
    required this.lastRestock,
    required this.expiryDate,
  });

  InventoryItem copyWith({
    String? id,
    String? name,
    String? category,
    int? currentStock,
    int? minStock,
    String? unit,
    int? cost,
    String? supplier,
    DateTime? lastRestock,
    DateTime? expiryDate,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      unit: unit ?? this.unit,
      cost: cost ?? this.cost,
      supplier: supplier ?? this.supplier,
      lastRestock: lastRestock ?? this.lastRestock,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  factory InventoryItem.empty() {
    return InventoryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      category: 'Филлеры',
      currentStock: 0,
      minStock: 0,
      unit: 'шт',
      cost: 0,
      supplier: '',
      lastRestock: DateTime.now(),
      expiryDate: DateTime.now().add(const Duration(days: 365)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'currentStock': currentStock,
      'minStock': minStock,
      'unit': unit,
      'cost': cost,
      'supplier': supplier,
      'lastRestock': lastRestock.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      currentStock: json['currentStock'] as int,
      minStock: json['minStock'] as int,
      unit: json['unit'] as String,
      cost: json['cost'] as int,
      supplier: json['supplier'] as String,
      lastRestock: DateTime.parse(json['lastRestock'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
    );
  }
}



