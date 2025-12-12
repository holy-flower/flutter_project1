import 'package:drift/drift.dart';

class Appointments extends Table {
  TextColumn get id => text()();
  TextColumn get clientName => text()();
  TextColumn get service => text()();
  IntColumn get appointmentDateTime => integer()();
  TextColumn get notes => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('scheduled'))();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  IntColumn get currentStock => integer()();
  IntColumn get minStock => integer()();
  TextColumn get unit => text()();
  IntColumn get cost => integer()();
  TextColumn get supplier => text()();
  IntColumn get lastRestock => integer()();
  IntColumn get expiryDate => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class FinancialRecords extends Table {
  TextColumn get id => text()();
  IntColumn get date => integer()();
  TextColumn get service => text()();
  IntColumn get amount => integer()();
  TextColumn get client => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ServiceCategories extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get route => text()();
  TextColumn get description => text()();
  IntColumn get serviceCount => integer()();
  IntColumn get totalPrice => integer()();
  BoolColumn get isPopular => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Services extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get duration => text()();
  TextColumn get price => text()();
  TextColumn get description => text()();
  TextColumn get details => text().nullable()();
  TextColumn get effects => text().nullable()();
  TextColumn get features => text().nullable()();
  TextColumn get zones => text().nullable()();
  TextColumn get techniques => text().nullable()();
  TextColumn get benefits => text().nullable()();
  TextColumn get includes => text().nullable()();
  TextColumn get indication => text().nullable()();
  IntColumn get colorValue => integer().nullable()();
  TextColumn get type => text()();

  @override
  Set<Column> get primaryKey => {id};
}

