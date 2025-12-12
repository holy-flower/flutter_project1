// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceMeta = const VerificationMeta(
    'service',
  );
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
    'service',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appointmentDateTimeMeta =
      const VerificationMeta('appointmentDateTime');
  @override
  late final GeneratedColumn<int> appointmentDateTime = GeneratedColumn<int>(
    'appointment_date_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scheduled'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientName,
    service,
    appointmentDateTime,
    notes,
    phone,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('service')) {
      context.handle(
        _serviceMeta,
        service.isAcceptableOrUnknown(data['service']!, _serviceMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceMeta);
    }
    if (data.containsKey('appointment_date_time')) {
      context.handle(
        _appointmentDateTimeMeta,
        appointmentDateTime.isAcceptableOrUnknown(
          data['appointment_date_time']!,
          _appointmentDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentDateTimeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      service: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service'],
      )!,
      appointmentDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}appointment_date_time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  final String id;
  final String clientName;
  final String service;
  final int appointmentDateTime;
  final String? notes;
  final String? phone;
  final String status;
  const Appointment({
    required this.id,
    required this.clientName,
    required this.service,
    required this.appointmentDateTime,
    this.notes,
    this.phone,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_name'] = Variable<String>(clientName);
    map['service'] = Variable<String>(service);
    map['appointment_date_time'] = Variable<int>(appointmentDateTime);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: Value(id),
      clientName: Value(clientName),
      service: Value(service),
      appointmentDateTime: Value(appointmentDateTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      status: Value(status),
    );
  }

  factory Appointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      id: serializer.fromJson<String>(json['id']),
      clientName: serializer.fromJson<String>(json['clientName']),
      service: serializer.fromJson<String>(json['service']),
      appointmentDateTime: serializer.fromJson<int>(
        json['appointmentDateTime'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      phone: serializer.fromJson<String?>(json['phone']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientName': serializer.toJson<String>(clientName),
      'service': serializer.toJson<String>(service),
      'appointmentDateTime': serializer.toJson<int>(appointmentDateTime),
      'notes': serializer.toJson<String?>(notes),
      'phone': serializer.toJson<String?>(phone),
      'status': serializer.toJson<String>(status),
    };
  }

  Appointment copyWith({
    String? id,
    String? clientName,
    String? service,
    int? appointmentDateTime,
    Value<String?> notes = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? status,
  }) => Appointment(
    id: id ?? this.id,
    clientName: clientName ?? this.clientName,
    service: service ?? this.service,
    appointmentDateTime: appointmentDateTime ?? this.appointmentDateTime,
    notes: notes.present ? notes.value : this.notes,
    phone: phone.present ? phone.value : this.phone,
    status: status ?? this.status,
  );
  Appointment copyWithCompanion(AppointmentsCompanion data) {
    return Appointment(
      id: data.id.present ? data.id.value : this.id,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      service: data.service.present ? data.service.value : this.service,
      appointmentDateTime: data.appointmentDateTime.present
          ? data.appointmentDateTime.value
          : this.appointmentDateTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      phone: data.phone.present ? data.phone.value : this.phone,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('id: $id, ')
          ..write('clientName: $clientName, ')
          ..write('service: $service, ')
          ..write('appointmentDateTime: $appointmentDateTime, ')
          ..write('notes: $notes, ')
          ..write('phone: $phone, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientName,
    service,
    appointmentDateTime,
    notes,
    phone,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.id == this.id &&
          other.clientName == this.clientName &&
          other.service == this.service &&
          other.appointmentDateTime == this.appointmentDateTime &&
          other.notes == this.notes &&
          other.phone == this.phone &&
          other.status == this.status);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<String> id;
  final Value<String> clientName;
  final Value<String> service;
  final Value<int> appointmentDateTime;
  final Value<String?> notes;
  final Value<String?> phone;
  final Value<String> status;
  final Value<int> rowid;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.clientName = const Value.absent(),
    this.service = const Value.absent(),
    this.appointmentDateTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    required String id,
    required String clientName,
    required String service,
    required int appointmentDateTime,
    this.notes = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientName = Value(clientName),
       service = Value(service),
       appointmentDateTime = Value(appointmentDateTime);
  static Insertable<Appointment> custom({
    Expression<String>? id,
    Expression<String>? clientName,
    Expression<String>? service,
    Expression<int>? appointmentDateTime,
    Expression<String>? notes,
    Expression<String>? phone,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientName != null) 'client_name': clientName,
      if (service != null) 'service': service,
      if (appointmentDateTime != null)
        'appointment_date_time': appointmentDateTime,
      if (notes != null) 'notes': notes,
      if (phone != null) 'phone': phone,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppointmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientName,
    Value<String>? service,
    Value<int>? appointmentDateTime,
    Value<String?>? notes,
    Value<String?>? phone,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      service: service ?? this.service,
      appointmentDateTime: appointmentDateTime ?? this.appointmentDateTime,
      notes: notes ?? this.notes,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (appointmentDateTime.present) {
      map['appointment_date_time'] = Variable<int>(appointmentDateTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('clientName: $clientName, ')
          ..write('service: $service, ')
          ..write('appointmentDateTime: $appointmentDateTime, ')
          ..write('notes: $notes, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<int> currentStock = GeneratedColumn<int>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minStockMeta = const VerificationMeta(
    'minStock',
  );
  @override
  late final GeneratedColumn<int> minStock = GeneratedColumn<int>(
    'min_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastRestockMeta = const VerificationMeta(
    'lastRestock',
  );
  @override
  late final GeneratedColumn<int> lastRestock = GeneratedColumn<int>(
    'last_restock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<int> expiryDate = GeneratedColumn<int>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    currentStock,
    minStock,
    unit,
    cost,
    supplier,
    lastRestock,
    expiryDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentStockMeta);
    }
    if (data.containsKey('min_stock')) {
      context.handle(
        _minStockMeta,
        minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta),
      );
    } else if (isInserting) {
      context.missing(_minStockMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierMeta);
    }
    if (data.containsKey('last_restock')) {
      context.handle(
        _lastRestockMeta,
        lastRestock.isAcceptableOrUnknown(
          data['last_restock']!,
          _lastRestockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastRestockMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_stock'],
      )!,
      minStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_stock'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      )!,
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      )!,
      lastRestock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_restock'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expiry_date'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final String name;
  final String category;
  final int currentStock;
  final int minStock;
  final String unit;
  final int cost;
  final String supplier;
  final int lastRestock;
  final int expiryDate;
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['current_stock'] = Variable<int>(currentStock);
    map['min_stock'] = Variable<int>(minStock);
    map['unit'] = Variable<String>(unit);
    map['cost'] = Variable<int>(cost);
    map['supplier'] = Variable<String>(supplier);
    map['last_restock'] = Variable<int>(lastRestock);
    map['expiry_date'] = Variable<int>(expiryDate);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      currentStock: Value(currentStock),
      minStock: Value(minStock),
      unit: Value(unit),
      cost: Value(cost),
      supplier: Value(supplier),
      lastRestock: Value(lastRestock),
      expiryDate: Value(expiryDate),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      currentStock: serializer.fromJson<int>(json['currentStock']),
      minStock: serializer.fromJson<int>(json['minStock']),
      unit: serializer.fromJson<String>(json['unit']),
      cost: serializer.fromJson<int>(json['cost']),
      supplier: serializer.fromJson<String>(json['supplier']),
      lastRestock: serializer.fromJson<int>(json['lastRestock']),
      expiryDate: serializer.fromJson<int>(json['expiryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'currentStock': serializer.toJson<int>(currentStock),
      'minStock': serializer.toJson<int>(minStock),
      'unit': serializer.toJson<String>(unit),
      'cost': serializer.toJson<int>(cost),
      'supplier': serializer.toJson<String>(supplier),
      'lastRestock': serializer.toJson<int>(lastRestock),
      'expiryDate': serializer.toJson<int>(expiryDate),
    };
  }

  InventoryItem copyWith({
    String? id,
    String? name,
    String? category,
    int? currentStock,
    int? minStock,
    String? unit,
    int? cost,
    String? supplier,
    int? lastRestock,
    int? expiryDate,
  }) => InventoryItem(
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
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      unit: data.unit.present ? data.unit.value : this.unit,
      cost: data.cost.present ? data.cost.value : this.cost,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      lastRestock: data.lastRestock.present
          ? data.lastRestock.value
          : this.lastRestock,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('currentStock: $currentStock, ')
          ..write('minStock: $minStock, ')
          ..write('unit: $unit, ')
          ..write('cost: $cost, ')
          ..write('supplier: $supplier, ')
          ..write('lastRestock: $lastRestock, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    currentStock,
    minStock,
    unit,
    cost,
    supplier,
    lastRestock,
    expiryDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.currentStock == this.currentStock &&
          other.minStock == this.minStock &&
          other.unit == this.unit &&
          other.cost == this.cost &&
          other.supplier == this.supplier &&
          other.lastRestock == this.lastRestock &&
          other.expiryDate == this.expiryDate);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<int> currentStock;
  final Value<int> minStock;
  final Value<String> unit;
  final Value<int> cost;
  final Value<String> supplier;
  final Value<int> lastRestock;
  final Value<int> expiryDate;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.minStock = const Value.absent(),
    this.unit = const Value.absent(),
    this.cost = const Value.absent(),
    this.supplier = const Value.absent(),
    this.lastRestock = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required int currentStock,
    required int minStock,
    required String unit,
    required int cost,
    required String supplier,
    required int lastRestock,
    required int expiryDate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       currentStock = Value(currentStock),
       minStock = Value(minStock),
       unit = Value(unit),
       cost = Value(cost),
       supplier = Value(supplier),
       lastRestock = Value(lastRestock),
       expiryDate = Value(expiryDate);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? currentStock,
    Expression<int>? minStock,
    Expression<String>? unit,
    Expression<int>? cost,
    Expression<String>? supplier,
    Expression<int>? lastRestock,
    Expression<int>? expiryDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (currentStock != null) 'current_stock': currentStock,
      if (minStock != null) 'min_stock': minStock,
      if (unit != null) 'unit': unit,
      if (cost != null) 'cost': cost,
      if (supplier != null) 'supplier': supplier,
      if (lastRestock != null) 'last_restock': lastRestock,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<int>? currentStock,
    Value<int>? minStock,
    Value<String>? unit,
    Value<int>? cost,
    Value<String>? supplier,
    Value<int>? lastRestock,
    Value<int>? expiryDate,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<int>(currentStock.value);
    }
    if (minStock.present) {
      map['min_stock'] = Variable<int>(minStock.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (lastRestock.present) {
      map['last_restock'] = Variable<int>(lastRestock.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<int>(expiryDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('currentStock: $currentStock, ')
          ..write('minStock: $minStock, ')
          ..write('unit: $unit, ')
          ..write('cost: $cost, ')
          ..write('supplier: $supplier, ')
          ..write('lastRestock: $lastRestock, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialRecordsTable extends FinancialRecords
    with TableInfo<$FinancialRecordsTable, FinancialRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceMeta = const VerificationMeta(
    'service',
  );
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
    'service',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientMeta = const VerificationMeta('client');
  @override
  late final GeneratedColumn<String> client = GeneratedColumn<String>(
    'client',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    service,
    amount,
    client,
    description,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('service')) {
      context.handle(
        _serviceMeta,
        service.isAcceptableOrUnknown(data['service']!, _serviceMeta),
      );
    } else if (isInserting) {
      context.missing(_serviceMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('client')) {
      context.handle(
        _clientMeta,
        client.isAcceptableOrUnknown(data['client']!, _clientMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      service: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      client: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $FinancialRecordsTable createAlias(String alias) {
    return $FinancialRecordsTable(attachedDatabase, alias);
  }
}

class FinancialRecord extends DataClass implements Insertable<FinancialRecord> {
  final String id;
  final int date;
  final String service;
  final int amount;
  final String client;
  final String description;
  final String type;
  const FinancialRecord({
    required this.id,
    required this.date,
    required this.service,
    required this.amount,
    required this.client,
    required this.description,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<int>(date);
    map['service'] = Variable<String>(service);
    map['amount'] = Variable<int>(amount);
    map['client'] = Variable<String>(client);
    map['description'] = Variable<String>(description);
    map['type'] = Variable<String>(type);
    return map;
  }

  FinancialRecordsCompanion toCompanion(bool nullToAbsent) {
    return FinancialRecordsCompanion(
      id: Value(id),
      date: Value(date),
      service: Value(service),
      amount: Value(amount),
      client: Value(client),
      description: Value(description),
      type: Value(type),
    );
  }

  factory FinancialRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialRecord(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<int>(json['date']),
      service: serializer.fromJson<String>(json['service']),
      amount: serializer.fromJson<int>(json['amount']),
      client: serializer.fromJson<String>(json['client']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<int>(date),
      'service': serializer.toJson<String>(service),
      'amount': serializer.toJson<int>(amount),
      'client': serializer.toJson<String>(client),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
    };
  }

  FinancialRecord copyWith({
    String? id,
    int? date,
    String? service,
    int? amount,
    String? client,
    String? description,
    String? type,
  }) => FinancialRecord(
    id: id ?? this.id,
    date: date ?? this.date,
    service: service ?? this.service,
    amount: amount ?? this.amount,
    client: client ?? this.client,
    description: description ?? this.description,
    type: type ?? this.type,
  );
  FinancialRecord copyWithCompanion(FinancialRecordsCompanion data) {
    return FinancialRecord(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      service: data.service.present ? data.service.value : this.service,
      amount: data.amount.present ? data.amount.value : this.amount,
      client: data.client.present ? data.client.value : this.client,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialRecord(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('service: $service, ')
          ..write('amount: $amount, ')
          ..write('client: $client, ')
          ..write('description: $description, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, service, amount, client, description, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialRecord &&
          other.id == this.id &&
          other.date == this.date &&
          other.service == this.service &&
          other.amount == this.amount &&
          other.client == this.client &&
          other.description == this.description &&
          other.type == this.type);
}

class FinancialRecordsCompanion extends UpdateCompanion<FinancialRecord> {
  final Value<String> id;
  final Value<int> date;
  final Value<String> service;
  final Value<int> amount;
  final Value<String> client;
  final Value<String> description;
  final Value<String> type;
  final Value<int> rowid;
  const FinancialRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.service = const Value.absent(),
    this.amount = const Value.absent(),
    this.client = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialRecordsCompanion.insert({
    required String id,
    required int date,
    required String service,
    required int amount,
    this.client = const Value.absent(),
    this.description = const Value.absent(),
    required String type,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       service = Value(service),
       amount = Value(amount),
       type = Value(type);
  static Insertable<FinancialRecord> custom({
    Expression<String>? id,
    Expression<int>? date,
    Expression<String>? service,
    Expression<int>? amount,
    Expression<String>? client,
    Expression<String>? description,
    Expression<String>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (service != null) 'service': service,
      if (amount != null) 'amount': amount,
      if (client != null) 'client': client,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialRecordsCompanion copyWith({
    Value<String>? id,
    Value<int>? date,
    Value<String>? service,
    Value<int>? amount,
    Value<String>? client,
    Value<String>? description,
    Value<String>? type,
    Value<int>? rowid,
  }) {
    return FinancialRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      service: service ?? this.service,
      amount: amount ?? this.amount,
      client: client ?? this.client,
      description: description ?? this.description,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (client.present) {
      map['client'] = Variable<String>(client.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('service: $service, ')
          ..write('amount: $amount, ')
          ..write('client: $client, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceCategoriesTable extends ServiceCategories
    with TableInfo<$ServiceCategoriesTable, ServiceCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routeMeta = const VerificationMeta('route');
  @override
  late final GeneratedColumn<String> route = GeneratedColumn<String>(
    'route',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceCountMeta = const VerificationMeta(
    'serviceCount',
  );
  @override
  late final GeneratedColumn<int> serviceCount = GeneratedColumn<int>(
    'service_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<int> totalPrice = GeneratedColumn<int>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPopularMeta = const VerificationMeta(
    'isPopular',
  );
  @override
  late final GeneratedColumn<bool> isPopular = GeneratedColumn<bool>(
    'is_popular',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_popular" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    route,
    description,
    serviceCount,
    totalPrice,
    isPopular,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('route')) {
      context.handle(
        _routeMeta,
        route.isAcceptableOrUnknown(data['route']!, _routeMeta),
      );
    } else if (isInserting) {
      context.missing(_routeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('service_count')) {
      context.handle(
        _serviceCountMeta,
        serviceCount.isAcceptableOrUnknown(
          data['service_count']!,
          _serviceCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceCountMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('is_popular')) {
      context.handle(
        _isPopularMeta,
        isPopular.isAcceptableOrUnknown(data['is_popular']!, _isPopularMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      route: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      serviceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}service_count'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_price'],
      )!,
      isPopular: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_popular'],
      )!,
    );
  }

  @override
  $ServiceCategoriesTable createAlias(String alias) {
    return $ServiceCategoriesTable(attachedDatabase, alias);
  }
}

class ServiceCategory extends DataClass implements Insertable<ServiceCategory> {
  final String id;
  final String title;
  final String route;
  final String description;
  final int serviceCount;
  final int totalPrice;
  final bool isPopular;
  const ServiceCategory({
    required this.id,
    required this.title,
    required this.route,
    required this.description,
    required this.serviceCount,
    required this.totalPrice,
    required this.isPopular,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['route'] = Variable<String>(route);
    map['description'] = Variable<String>(description);
    map['service_count'] = Variable<int>(serviceCount);
    map['total_price'] = Variable<int>(totalPrice);
    map['is_popular'] = Variable<bool>(isPopular);
    return map;
  }

  ServiceCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ServiceCategoriesCompanion(
      id: Value(id),
      title: Value(title),
      route: Value(route),
      description: Value(description),
      serviceCount: Value(serviceCount),
      totalPrice: Value(totalPrice),
      isPopular: Value(isPopular),
    );
  }

  factory ServiceCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceCategory(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      route: serializer.fromJson<String>(json['route']),
      description: serializer.fromJson<String>(json['description']),
      serviceCount: serializer.fromJson<int>(json['serviceCount']),
      totalPrice: serializer.fromJson<int>(json['totalPrice']),
      isPopular: serializer.fromJson<bool>(json['isPopular']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'route': serializer.toJson<String>(route),
      'description': serializer.toJson<String>(description),
      'serviceCount': serializer.toJson<int>(serviceCount),
      'totalPrice': serializer.toJson<int>(totalPrice),
      'isPopular': serializer.toJson<bool>(isPopular),
    };
  }

  ServiceCategory copyWith({
    String? id,
    String? title,
    String? route,
    String? description,
    int? serviceCount,
    int? totalPrice,
    bool? isPopular,
  }) => ServiceCategory(
    id: id ?? this.id,
    title: title ?? this.title,
    route: route ?? this.route,
    description: description ?? this.description,
    serviceCount: serviceCount ?? this.serviceCount,
    totalPrice: totalPrice ?? this.totalPrice,
    isPopular: isPopular ?? this.isPopular,
  );
  ServiceCategory copyWithCompanion(ServiceCategoriesCompanion data) {
    return ServiceCategory(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      route: data.route.present ? data.route.value : this.route,
      description: data.description.present
          ? data.description.value
          : this.description,
      serviceCount: data.serviceCount.present
          ? data.serviceCount.value
          : this.serviceCount,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      isPopular: data.isPopular.present ? data.isPopular.value : this.isPopular,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceCategory(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('route: $route, ')
          ..write('description: $description, ')
          ..write('serviceCount: $serviceCount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('isPopular: $isPopular')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    route,
    description,
    serviceCount,
    totalPrice,
    isPopular,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceCategory &&
          other.id == this.id &&
          other.title == this.title &&
          other.route == this.route &&
          other.description == this.description &&
          other.serviceCount == this.serviceCount &&
          other.totalPrice == this.totalPrice &&
          other.isPopular == this.isPopular);
}

class ServiceCategoriesCompanion extends UpdateCompanion<ServiceCategory> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> route;
  final Value<String> description;
  final Value<int> serviceCount;
  final Value<int> totalPrice;
  final Value<bool> isPopular;
  final Value<int> rowid;
  const ServiceCategoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.route = const Value.absent(),
    this.description = const Value.absent(),
    this.serviceCount = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.isPopular = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceCategoriesCompanion.insert({
    required String id,
    required String title,
    required String route,
    required String description,
    required int serviceCount,
    required int totalPrice,
    this.isPopular = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       route = Value(route),
       description = Value(description),
       serviceCount = Value(serviceCount),
       totalPrice = Value(totalPrice);
  static Insertable<ServiceCategory> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? route,
    Expression<String>? description,
    Expression<int>? serviceCount,
    Expression<int>? totalPrice,
    Expression<bool>? isPopular,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (route != null) 'route': route,
      if (description != null) 'description': description,
      if (serviceCount != null) 'service_count': serviceCount,
      if (totalPrice != null) 'total_price': totalPrice,
      if (isPopular != null) 'is_popular': isPopular,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? route,
    Value<String>? description,
    Value<int>? serviceCount,
    Value<int>? totalPrice,
    Value<bool>? isPopular,
    Value<int>? rowid,
  }) {
    return ServiceCategoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      route: route ?? this.route,
      description: description ?? this.description,
      serviceCount: serviceCount ?? this.serviceCount,
      totalPrice: totalPrice ?? this.totalPrice,
      isPopular: isPopular ?? this.isPopular,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (route.present) {
      map['route'] = Variable<String>(route.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (serviceCount.present) {
      map['service_count'] = Variable<int>(serviceCount.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<int>(totalPrice.value);
    }
    if (isPopular.present) {
      map['is_popular'] = Variable<bool>(isPopular.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('route: $route, ')
          ..write('description: $description, ')
          ..write('serviceCount: $serviceCount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('isPopular: $isPopular, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services with TableInfo<$ServicesTable, Service> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectsMeta = const VerificationMeta(
    'effects',
  );
  @override
  late final GeneratedColumn<String> effects = GeneratedColumn<String>(
    'effects',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _featuresMeta = const VerificationMeta(
    'features',
  );
  @override
  late final GeneratedColumn<String> features = GeneratedColumn<String>(
    'features',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zonesMeta = const VerificationMeta('zones');
  @override
  late final GeneratedColumn<String> zones = GeneratedColumn<String>(
    'zones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _techniquesMeta = const VerificationMeta(
    'techniques',
  );
  @override
  late final GeneratedColumn<String> techniques = GeneratedColumn<String>(
    'techniques',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _benefitsMeta = const VerificationMeta(
    'benefits',
  );
  @override
  late final GeneratedColumn<String> benefits = GeneratedColumn<String>(
    'benefits',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _includesMeta = const VerificationMeta(
    'includes',
  );
  @override
  late final GeneratedColumn<String> includes = GeneratedColumn<String>(
    'includes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _indicationMeta = const VerificationMeta(
    'indication',
  );
  @override
  late final GeneratedColumn<String> indication = GeneratedColumn<String>(
    'indication',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    duration,
    price,
    description,
    details,
    effects,
    features,
    zones,
    techniques,
    benefits,
    includes,
    indication,
    colorValue,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(
    Insertable<Service> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('effects')) {
      context.handle(
        _effectsMeta,
        effects.isAcceptableOrUnknown(data['effects']!, _effectsMeta),
      );
    }
    if (data.containsKey('features')) {
      context.handle(
        _featuresMeta,
        features.isAcceptableOrUnknown(data['features']!, _featuresMeta),
      );
    }
    if (data.containsKey('zones')) {
      context.handle(
        _zonesMeta,
        zones.isAcceptableOrUnknown(data['zones']!, _zonesMeta),
      );
    }
    if (data.containsKey('techniques')) {
      context.handle(
        _techniquesMeta,
        techniques.isAcceptableOrUnknown(data['techniques']!, _techniquesMeta),
      );
    }
    if (data.containsKey('benefits')) {
      context.handle(
        _benefitsMeta,
        benefits.isAcceptableOrUnknown(data['benefits']!, _benefitsMeta),
      );
    }
    if (data.containsKey('includes')) {
      context.handle(
        _includesMeta,
        includes.isAcceptableOrUnknown(data['includes']!, _includesMeta),
      );
    }
    if (data.containsKey('indication')) {
      context.handle(
        _indicationMeta,
        indication.isAcceptableOrUnknown(data['indication']!, _indicationMeta),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Service map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Service(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      effects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effects'],
      ),
      features: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}features'],
      ),
      zones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zones'],
      ),
      techniques: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}techniques'],
      ),
      benefits: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}benefits'],
      ),
      includes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}includes'],
      ),
      indication: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}indication'],
      ),
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class Service extends DataClass implements Insertable<Service> {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String description;
  final String? details;
  final String? effects;
  final String? features;
  final String? zones;
  final String? techniques;
  final String? benefits;
  final String? includes;
  final String? indication;
  final int? colorValue;
  final String type;
  const Service({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    this.details,
    this.effects,
    this.features,
    this.zones,
    this.techniques,
    this.benefits,
    this.includes,
    this.indication,
    this.colorValue,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['duration'] = Variable<String>(duration);
    map['price'] = Variable<String>(price);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    if (!nullToAbsent || effects != null) {
      map['effects'] = Variable<String>(effects);
    }
    if (!nullToAbsent || features != null) {
      map['features'] = Variable<String>(features);
    }
    if (!nullToAbsent || zones != null) {
      map['zones'] = Variable<String>(zones);
    }
    if (!nullToAbsent || techniques != null) {
      map['techniques'] = Variable<String>(techniques);
    }
    if (!nullToAbsent || benefits != null) {
      map['benefits'] = Variable<String>(benefits);
    }
    if (!nullToAbsent || includes != null) {
      map['includes'] = Variable<String>(includes);
    }
    if (!nullToAbsent || indication != null) {
      map['indication'] = Variable<String>(indication);
    }
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['type'] = Variable<String>(type);
    return map;
  }

  ServicesCompanion toCompanion(bool nullToAbsent) {
    return ServicesCompanion(
      id: Value(id),
      title: Value(title),
      duration: Value(duration),
      price: Value(price),
      description: Value(description),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      effects: effects == null && nullToAbsent
          ? const Value.absent()
          : Value(effects),
      features: features == null && nullToAbsent
          ? const Value.absent()
          : Value(features),
      zones: zones == null && nullToAbsent
          ? const Value.absent()
          : Value(zones),
      techniques: techniques == null && nullToAbsent
          ? const Value.absent()
          : Value(techniques),
      benefits: benefits == null && nullToAbsent
          ? const Value.absent()
          : Value(benefits),
      includes: includes == null && nullToAbsent
          ? const Value.absent()
          : Value(includes),
      indication: indication == null && nullToAbsent
          ? const Value.absent()
          : Value(indication),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      type: Value(type),
    );
  }

  factory Service.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Service(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      duration: serializer.fromJson<String>(json['duration']),
      price: serializer.fromJson<String>(json['price']),
      description: serializer.fromJson<String>(json['description']),
      details: serializer.fromJson<String?>(json['details']),
      effects: serializer.fromJson<String?>(json['effects']),
      features: serializer.fromJson<String?>(json['features']),
      zones: serializer.fromJson<String?>(json['zones']),
      techniques: serializer.fromJson<String?>(json['techniques']),
      benefits: serializer.fromJson<String?>(json['benefits']),
      includes: serializer.fromJson<String?>(json['includes']),
      indication: serializer.fromJson<String?>(json['indication']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'duration': serializer.toJson<String>(duration),
      'price': serializer.toJson<String>(price),
      'description': serializer.toJson<String>(description),
      'details': serializer.toJson<String?>(details),
      'effects': serializer.toJson<String?>(effects),
      'features': serializer.toJson<String?>(features),
      'zones': serializer.toJson<String?>(zones),
      'techniques': serializer.toJson<String?>(techniques),
      'benefits': serializer.toJson<String?>(benefits),
      'includes': serializer.toJson<String?>(includes),
      'indication': serializer.toJson<String?>(indication),
      'colorValue': serializer.toJson<int?>(colorValue),
      'type': serializer.toJson<String>(type),
    };
  }

  Service copyWith({
    String? id,
    String? title,
    String? duration,
    String? price,
    String? description,
    Value<String?> details = const Value.absent(),
    Value<String?> effects = const Value.absent(),
    Value<String?> features = const Value.absent(),
    Value<String?> zones = const Value.absent(),
    Value<String?> techniques = const Value.absent(),
    Value<String?> benefits = const Value.absent(),
    Value<String?> includes = const Value.absent(),
    Value<String?> indication = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
    String? type,
  }) => Service(
    id: id ?? this.id,
    title: title ?? this.title,
    duration: duration ?? this.duration,
    price: price ?? this.price,
    description: description ?? this.description,
    details: details.present ? details.value : this.details,
    effects: effects.present ? effects.value : this.effects,
    features: features.present ? features.value : this.features,
    zones: zones.present ? zones.value : this.zones,
    techniques: techniques.present ? techniques.value : this.techniques,
    benefits: benefits.present ? benefits.value : this.benefits,
    includes: includes.present ? includes.value : this.includes,
    indication: indication.present ? indication.value : this.indication,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    type: type ?? this.type,
  );
  Service copyWithCompanion(ServicesCompanion data) {
    return Service(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      duration: data.duration.present ? data.duration.value : this.duration,
      price: data.price.present ? data.price.value : this.price,
      description: data.description.present
          ? data.description.value
          : this.description,
      details: data.details.present ? data.details.value : this.details,
      effects: data.effects.present ? data.effects.value : this.effects,
      features: data.features.present ? data.features.value : this.features,
      zones: data.zones.present ? data.zones.value : this.zones,
      techniques: data.techniques.present
          ? data.techniques.value
          : this.techniques,
      benefits: data.benefits.present ? data.benefits.value : this.benefits,
      includes: data.includes.present ? data.includes.value : this.includes,
      indication: data.indication.present
          ? data.indication.value
          : this.indication,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Service(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('duration: $duration, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('details: $details, ')
          ..write('effects: $effects, ')
          ..write('features: $features, ')
          ..write('zones: $zones, ')
          ..write('techniques: $techniques, ')
          ..write('benefits: $benefits, ')
          ..write('includes: $includes, ')
          ..write('indication: $indication, ')
          ..write('colorValue: $colorValue, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    duration,
    price,
    description,
    details,
    effects,
    features,
    zones,
    techniques,
    benefits,
    includes,
    indication,
    colorValue,
    type,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Service &&
          other.id == this.id &&
          other.title == this.title &&
          other.duration == this.duration &&
          other.price == this.price &&
          other.description == this.description &&
          other.details == this.details &&
          other.effects == this.effects &&
          other.features == this.features &&
          other.zones == this.zones &&
          other.techniques == this.techniques &&
          other.benefits == this.benefits &&
          other.includes == this.includes &&
          other.indication == this.indication &&
          other.colorValue == this.colorValue &&
          other.type == this.type);
}

class ServicesCompanion extends UpdateCompanion<Service> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> duration;
  final Value<String> price;
  final Value<String> description;
  final Value<String?> details;
  final Value<String?> effects;
  final Value<String?> features;
  final Value<String?> zones;
  final Value<String?> techniques;
  final Value<String?> benefits;
  final Value<String?> includes;
  final Value<String?> indication;
  final Value<int?> colorValue;
  final Value<String> type;
  final Value<int> rowid;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.duration = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
    this.details = const Value.absent(),
    this.effects = const Value.absent(),
    this.features = const Value.absent(),
    this.zones = const Value.absent(),
    this.techniques = const Value.absent(),
    this.benefits = const Value.absent(),
    this.includes = const Value.absent(),
    this.indication = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesCompanion.insert({
    required String id,
    required String title,
    required String duration,
    required String price,
    required String description,
    this.details = const Value.absent(),
    this.effects = const Value.absent(),
    this.features = const Value.absent(),
    this.zones = const Value.absent(),
    this.techniques = const Value.absent(),
    this.benefits = const Value.absent(),
    this.includes = const Value.absent(),
    this.indication = const Value.absent(),
    this.colorValue = const Value.absent(),
    required String type,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       duration = Value(duration),
       price = Value(price),
       description = Value(description),
       type = Value(type);
  static Insertable<Service> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? duration,
    Expression<String>? price,
    Expression<String>? description,
    Expression<String>? details,
    Expression<String>? effects,
    Expression<String>? features,
    Expression<String>? zones,
    Expression<String>? techniques,
    Expression<String>? benefits,
    Expression<String>? includes,
    Expression<String>? indication,
    Expression<int>? colorValue,
    Expression<String>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (duration != null) 'duration': duration,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (details != null) 'details': details,
      if (effects != null) 'effects': effects,
      if (features != null) 'features': features,
      if (zones != null) 'zones': zones,
      if (techniques != null) 'techniques': techniques,
      if (benefits != null) 'benefits': benefits,
      if (includes != null) 'includes': includes,
      if (indication != null) 'indication': indication,
      if (colorValue != null) 'color_value': colorValue,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? duration,
    Value<String>? price,
    Value<String>? description,
    Value<String?>? details,
    Value<String?>? effects,
    Value<String?>? features,
    Value<String?>? zones,
    Value<String?>? techniques,
    Value<String?>? benefits,
    Value<String?>? includes,
    Value<String?>? indication,
    Value<int?>? colorValue,
    Value<String>? type,
    Value<int>? rowid,
  }) {
    return ServicesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      description: description ?? this.description,
      details: details ?? this.details,
      effects: effects ?? this.effects,
      features: features ?? this.features,
      zones: zones ?? this.zones,
      techniques: techniques ?? this.techniques,
      benefits: benefits ?? this.benefits,
      includes: includes ?? this.includes,
      indication: indication ?? this.indication,
      colorValue: colorValue ?? this.colorValue,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (effects.present) {
      map['effects'] = Variable<String>(effects.value);
    }
    if (features.present) {
      map['features'] = Variable<String>(features.value);
    }
    if (zones.present) {
      map['zones'] = Variable<String>(zones.value);
    }
    if (techniques.present) {
      map['techniques'] = Variable<String>(techniques.value);
    }
    if (benefits.present) {
      map['benefits'] = Variable<String>(benefits.value);
    }
    if (includes.present) {
      map['includes'] = Variable<String>(includes.value);
    }
    if (indication.present) {
      map['indication'] = Variable<String>(indication.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('duration: $duration, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('details: $details, ')
          ..write('effects: $effects, ')
          ..write('features: $features, ')
          ..write('zones: $zones, ')
          ..write('techniques: $techniques, ')
          ..write('benefits: $benefits, ')
          ..write('includes: $includes, ')
          ..write('indication: $indication, ')
          ..write('colorValue: $colorValue, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $FinancialRecordsTable financialRecords = $FinancialRecordsTable(
    this,
  );
  late final $ServiceCategoriesTable serviceCategories =
      $ServiceCategoriesTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appointments,
    inventoryItems,
    financialRecords,
    serviceCategories,
    services,
  ];
}

typedef $$AppointmentsTableCreateCompanionBuilder =
    AppointmentsCompanion Function({
      required String id,
      required String clientName,
      required String service,
      required int appointmentDateTime,
      Value<String?> notes,
      Value<String?> phone,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$AppointmentsTableUpdateCompanionBuilder =
    AppointmentsCompanion Function({
      Value<String> id,
      Value<String> clientName,
      Value<String> service,
      Value<int> appointmentDateTime,
      Value<String?> notes,
      Value<String?> phone,
      Value<String> status,
      Value<int> rowid,
    });

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appointmentDateTime => $composableBuilder(
    column: $table.appointmentDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appointmentDateTime => $composableBuilder(
    column: $table.appointmentDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get service =>
      $composableBuilder(column: $table.service, builder: (column) => column);

  GeneratedColumn<int> get appointmentDateTime => $composableBuilder(
    column: $table.appointmentDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$AppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppointmentsTable,
          Appointment,
          $$AppointmentsTableFilterComposer,
          $$AppointmentsTableOrderingComposer,
          $$AppointmentsTableAnnotationComposer,
          $$AppointmentsTableCreateCompanionBuilder,
          $$AppointmentsTableUpdateCompanionBuilder,
          (
            Appointment,
            BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
          ),
          Appointment,
          PrefetchHooks Function()
        > {
  $$AppointmentsTableTableManager(_$AppDatabase db, $AppointmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<String> service = const Value.absent(),
                Value<int> appointmentDateTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsCompanion(
                id: id,
                clientName: clientName,
                service: service,
                appointmentDateTime: appointmentDateTime,
                notes: notes,
                phone: phone,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientName,
                required String service,
                required int appointmentDateTime,
                Value<String?> notes = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppointmentsCompanion.insert(
                id: id,
                clientName: clientName,
                service: service,
                appointmentDateTime: appointmentDateTime,
                notes: notes,
                phone: phone,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppointmentsTable,
      Appointment,
      $$AppointmentsTableFilterComposer,
      $$AppointmentsTableOrderingComposer,
      $$AppointmentsTableAnnotationComposer,
      $$AppointmentsTableCreateCompanionBuilder,
      $$AppointmentsTableUpdateCompanionBuilder,
      (
        Appointment,
        BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>,
      ),
      Appointment,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String id,
      required String name,
      required String category,
      required int currentStock,
      required int minStock,
      required String unit,
      required int cost,
      required String supplier,
      required int lastRestock,
      required int expiryDate,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> category,
      Value<int> currentStock,
      Value<int> minStock,
      Value<String> unit,
      Value<int> cost,
      Value<String> supplier,
      Value<int> lastRestock,
      Value<int> expiryDate,
      Value<int> rowid,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastRestock => $composableBuilder(
    column: $table.lastRestock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastRestock => $composableBuilder(
    column: $table.lastRestock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minStock =>
      $composableBuilder(column: $table.minStock, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<int> get lastRestock => $composableBuilder(
    column: $table.lastRestock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> currentStock = const Value.absent(),
                Value<int> minStock = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> cost = const Value.absent(),
                Value<String> supplier = const Value.absent(),
                Value<int> lastRestock = const Value.absent(),
                Value<int> expiryDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                name: name,
                category: category,
                currentStock: currentStock,
                minStock: minStock,
                unit: unit,
                cost: cost,
                supplier: supplier,
                lastRestock: lastRestock,
                expiryDate: expiryDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                required int currentStock,
                required int minStock,
                required String unit,
                required int cost,
                required String supplier,
                required int lastRestock,
                required int expiryDate,
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                name: name,
                category: category,
                currentStock: currentStock,
                minStock: minStock,
                unit: unit,
                cost: cost,
                supplier: supplier,
                lastRestock: lastRestock,
                expiryDate: expiryDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$FinancialRecordsTableCreateCompanionBuilder =
    FinancialRecordsCompanion Function({
      required String id,
      required int date,
      required String service,
      required int amount,
      Value<String> client,
      Value<String> description,
      required String type,
      Value<int> rowid,
    });
typedef $$FinancialRecordsTableUpdateCompanionBuilder =
    FinancialRecordsCompanion Function({
      Value<String> id,
      Value<int> date,
      Value<String> service,
      Value<int> amount,
      Value<String> client,
      Value<String> description,
      Value<String> type,
      Value<int> rowid,
    });

class $$FinancialRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialRecordsTable> {
  $$FinancialRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get client => $composableBuilder(
    column: $table.client,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinancialRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialRecordsTable> {
  $$FinancialRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get service => $composableBuilder(
    column: $table.service,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get client => $composableBuilder(
    column: $table.client,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinancialRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialRecordsTable> {
  $$FinancialRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get service =>
      $composableBuilder(column: $table.service, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get client =>
      $composableBuilder(column: $table.client, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$FinancialRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialRecordsTable,
          FinancialRecord,
          $$FinancialRecordsTableFilterComposer,
          $$FinancialRecordsTableOrderingComposer,
          $$FinancialRecordsTableAnnotationComposer,
          $$FinancialRecordsTableCreateCompanionBuilder,
          $$FinancialRecordsTableUpdateCompanionBuilder,
          (
            FinancialRecord,
            BaseReferences<
              _$AppDatabase,
              $FinancialRecordsTable,
              FinancialRecord
            >,
          ),
          FinancialRecord,
          PrefetchHooks Function()
        > {
  $$FinancialRecordsTableTableManager(
    _$AppDatabase db,
    $FinancialRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> date = const Value.absent(),
                Value<String> service = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> client = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialRecordsCompanion(
                id: id,
                date: date,
                service: service,
                amount: amount,
                client: client,
                description: description,
                type: type,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int date,
                required String service,
                required int amount,
                Value<String> client = const Value.absent(),
                Value<String> description = const Value.absent(),
                required String type,
                Value<int> rowid = const Value.absent(),
              }) => FinancialRecordsCompanion.insert(
                id: id,
                date: date,
                service: service,
                amount: amount,
                client: client,
                description: description,
                type: type,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinancialRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialRecordsTable,
      FinancialRecord,
      $$FinancialRecordsTableFilterComposer,
      $$FinancialRecordsTableOrderingComposer,
      $$FinancialRecordsTableAnnotationComposer,
      $$FinancialRecordsTableCreateCompanionBuilder,
      $$FinancialRecordsTableUpdateCompanionBuilder,
      (
        FinancialRecord,
        BaseReferences<_$AppDatabase, $FinancialRecordsTable, FinancialRecord>,
      ),
      FinancialRecord,
      PrefetchHooks Function()
    >;
typedef $$ServiceCategoriesTableCreateCompanionBuilder =
    ServiceCategoriesCompanion Function({
      required String id,
      required String title,
      required String route,
      required String description,
      required int serviceCount,
      required int totalPrice,
      Value<bool> isPopular,
      Value<int> rowid,
    });
typedef $$ServiceCategoriesTableUpdateCompanionBuilder =
    ServiceCategoriesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> route,
      Value<String> description,
      Value<int> serviceCount,
      Value<int> totalPrice,
      Value<bool> isPopular,
      Value<int> rowid,
    });

class $$ServiceCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTable> {
  $$ServiceCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serviceCount => $composableBuilder(
    column: $table.serviceCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPopular => $composableBuilder(
    column: $table.isPopular,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTable> {
  $$ServiceCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serviceCount => $composableBuilder(
    column: $table.serviceCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPopular => $composableBuilder(
    column: $table.isPopular,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTable> {
  $$ServiceCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get route =>
      $composableBuilder(column: $table.route, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serviceCount => $composableBuilder(
    column: $table.serviceCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPopular =>
      $composableBuilder(column: $table.isPopular, builder: (column) => column);
}

class $$ServiceCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceCategoriesTable,
          ServiceCategory,
          $$ServiceCategoriesTableFilterComposer,
          $$ServiceCategoriesTableOrderingComposer,
          $$ServiceCategoriesTableAnnotationComposer,
          $$ServiceCategoriesTableCreateCompanionBuilder,
          $$ServiceCategoriesTableUpdateCompanionBuilder,
          (
            ServiceCategory,
            BaseReferences<
              _$AppDatabase,
              $ServiceCategoriesTable,
              ServiceCategory
            >,
          ),
          ServiceCategory,
          PrefetchHooks Function()
        > {
  $$ServiceCategoriesTableTableManager(
    _$AppDatabase db,
    $ServiceCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> route = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> serviceCount = const Value.absent(),
                Value<int> totalPrice = const Value.absent(),
                Value<bool> isPopular = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceCategoriesCompanion(
                id: id,
                title: title,
                route: route,
                description: description,
                serviceCount: serviceCount,
                totalPrice: totalPrice,
                isPopular: isPopular,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String route,
                required String description,
                required int serviceCount,
                required int totalPrice,
                Value<bool> isPopular = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceCategoriesCompanion.insert(
                id: id,
                title: title,
                route: route,
                description: description,
                serviceCount: serviceCount,
                totalPrice: totalPrice,
                isPopular: isPopular,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceCategoriesTable,
      ServiceCategory,
      $$ServiceCategoriesTableFilterComposer,
      $$ServiceCategoriesTableOrderingComposer,
      $$ServiceCategoriesTableAnnotationComposer,
      $$ServiceCategoriesTableCreateCompanionBuilder,
      $$ServiceCategoriesTableUpdateCompanionBuilder,
      (
        ServiceCategory,
        BaseReferences<_$AppDatabase, $ServiceCategoriesTable, ServiceCategory>,
      ),
      ServiceCategory,
      PrefetchHooks Function()
    >;
typedef $$ServicesTableCreateCompanionBuilder =
    ServicesCompanion Function({
      required String id,
      required String title,
      required String duration,
      required String price,
      required String description,
      Value<String?> details,
      Value<String?> effects,
      Value<String?> features,
      Value<String?> zones,
      Value<String?> techniques,
      Value<String?> benefits,
      Value<String?> includes,
      Value<String?> indication,
      Value<int?> colorValue,
      required String type,
      Value<int> rowid,
    });
typedef $$ServicesTableUpdateCompanionBuilder =
    ServicesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> duration,
      Value<String> price,
      Value<String> description,
      Value<String?> details,
      Value<String?> effects,
      Value<String?> features,
      Value<String?> zones,
      Value<String?> techniques,
      Value<String?> benefits,
      Value<String?> includes,
      Value<String?> indication,
      Value<int?> colorValue,
      Value<String> type,
      Value<int> rowid,
    });

class $$ServicesTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effects => $composableBuilder(
    column: $table.effects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zones => $composableBuilder(
    column: $table.zones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techniques => $composableBuilder(
    column: $table.techniques,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get benefits => $composableBuilder(
    column: $table.benefits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get includes => $composableBuilder(
    column: $table.includes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get indication => $composableBuilder(
    column: $table.indication,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effects => $composableBuilder(
    column: $table.effects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zones => $composableBuilder(
    column: $table.zones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techniques => $composableBuilder(
    column: $table.techniques,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get benefits => $composableBuilder(
    column: $table.benefits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get includes => $composableBuilder(
    column: $table.includes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get indication => $composableBuilder(
    column: $table.indication,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get effects =>
      $composableBuilder(column: $table.effects, builder: (column) => column);

  GeneratedColumn<String> get features =>
      $composableBuilder(column: $table.features, builder: (column) => column);

  GeneratedColumn<String> get zones =>
      $composableBuilder(column: $table.zones, builder: (column) => column);

  GeneratedColumn<String> get techniques => $composableBuilder(
    column: $table.techniques,
    builder: (column) => column,
  );

  GeneratedColumn<String> get benefits =>
      $composableBuilder(column: $table.benefits, builder: (column) => column);

  GeneratedColumn<String> get includes =>
      $composableBuilder(column: $table.includes, builder: (column) => column);

  GeneratedColumn<String> get indication => $composableBuilder(
    column: $table.indication,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$ServicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServicesTable,
          Service,
          $$ServicesTableFilterComposer,
          $$ServicesTableOrderingComposer,
          $$ServicesTableAnnotationComposer,
          $$ServicesTableCreateCompanionBuilder,
          $$ServicesTableUpdateCompanionBuilder,
          (Service, BaseReferences<_$AppDatabase, $ServicesTable, Service>),
          Service,
          PrefetchHooks Function()
        > {
  $$ServicesTableTableManager(_$AppDatabase db, $ServicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> duration = const Value.absent(),
                Value<String> price = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<String?> effects = const Value.absent(),
                Value<String?> features = const Value.absent(),
                Value<String?> zones = const Value.absent(),
                Value<String?> techniques = const Value.absent(),
                Value<String?> benefits = const Value.absent(),
                Value<String?> includes = const Value.absent(),
                Value<String?> indication = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion(
                id: id,
                title: title,
                duration: duration,
                price: price,
                description: description,
                details: details,
                effects: effects,
                features: features,
                zones: zones,
                techniques: techniques,
                benefits: benefits,
                includes: includes,
                indication: indication,
                colorValue: colorValue,
                type: type,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String duration,
                required String price,
                required String description,
                Value<String?> details = const Value.absent(),
                Value<String?> effects = const Value.absent(),
                Value<String?> features = const Value.absent(),
                Value<String?> zones = const Value.absent(),
                Value<String?> techniques = const Value.absent(),
                Value<String?> benefits = const Value.absent(),
                Value<String?> includes = const Value.absent(),
                Value<String?> indication = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                required String type,
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion.insert(
                id: id,
                title: title,
                duration: duration,
                price: price,
                description: description,
                details: details,
                effects: effects,
                features: features,
                zones: zones,
                techniques: techniques,
                benefits: benefits,
                includes: includes,
                indication: indication,
                colorValue: colorValue,
                type: type,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServicesTable,
      Service,
      $$ServicesTableFilterComposer,
      $$ServicesTableOrderingComposer,
      $$ServicesTableAnnotationComposer,
      $$ServicesTableCreateCompanionBuilder,
      $$ServicesTableUpdateCompanionBuilder,
      (Service, BaseReferences<_$AppDatabase, $ServicesTable, Service>),
      Service,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$FinancialRecordsTableTableManager get financialRecords =>
      $$FinancialRecordsTableTableManager(_db, _db.financialRecords);
  $$ServiceCategoriesTableTableManager get serviceCategories =>
      $$ServiceCategoriesTableTableManager(_db, _db.serviceCategories);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db, _db.services);
}
