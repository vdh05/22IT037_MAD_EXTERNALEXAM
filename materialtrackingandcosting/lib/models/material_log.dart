import 'package:hive/hive.dart';

part 'material_log.g.dart';

@HiveType(typeId: 0)
class MaterialLog {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String materialName;
  
  @HiveField(2)
  final double quantity;
  
  @HiveField(3)
  final double cost;
  
  @HiveField(4)
  final DateTime date;
  
  @HiveField(5)
  final String? notes;
  
  MaterialLog({
    required this.id,
    required this.materialName,
    required this.quantity,
    required this.cost,
    required this.date,
    this.notes,
  });
  
  // Calculate total cost
  double get totalCost => quantity * cost;
}
