import 'package:hive_flutter/hive_flutter.dart';
import '../models/material_log.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static const String _materialLogBox = 'material_logs';
  static final DatabaseService _instance = DatabaseService._internal();
  final _uuid = Uuid();
  
  factory DatabaseService() {
    return _instance;
  }
  
  DatabaseService._internal();
  
  Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters if they haven't been registered yet
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MaterialLogAdapter());
    }
    
    await Hive.openBox<MaterialLog>(_materialLogBox);
  }
  
  // CRUD operations
  Future<String> addMaterialLog(String materialName, double quantity, double cost, 
      DateTime date, {String? notes}) async {
    final box = Hive.box<MaterialLog>(_materialLogBox);
    final id = _uuid.v4();
    
    final log = MaterialLog(
      id: id,
      materialName: materialName,
      quantity: quantity,
      cost: cost,
      date: date,
      notes: notes,
    );
    
    await box.put(id, log);
    return id;
  }
  
  Future<void> updateMaterialLog(MaterialLog log) async {
    final box = Hive.box<MaterialLog>(_materialLogBox);
    await box.put(log.id, log);
  }
  
  Future<void> deleteMaterialLog(String id) async {
    final box = Hive.box<MaterialLog>(_materialLogBox);
    await box.delete(id);
  }
  
  List<MaterialLog> getAllLogs() {
    final box = Hive.box<MaterialLog>(_materialLogBox);
    return box.values.toList();
  }
}
