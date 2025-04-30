import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/material_log.dart';

class CloudSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'material_logs';
  
  // Upload a single log
  Future<void> uploadLog(MaterialLog log) async {
    await _firestore.collection(_collection).doc(log.id).set({
      'materialName': log.materialName,
      'quantity': log.quantity,
      'cost': log.cost,
      'date': log.date.toIso8601String(),
      'notes': log.notes,
    });
  }
  
  // Sync all logs to Firebase
  Future<void> syncToCloud(List<MaterialLog> logs) async {
    final batch = _firestore.batch();
    
    for (var log in logs) {
      final docRef = _firestore.collection(_collection).doc(log.id);
      batch.set(docRef, {
        'materialName': log.materialName,
        'quantity': log.quantity,
        'cost': log.cost,
        'date': log.date.toIso8601String(),
        'notes': log.notes,
      });
    }
    
    await batch.commit();
  }
  
  // Download logs from Firebase
  Future<List<MaterialLog>> downloadLogs() async {
    final snapshot = await _firestore.collection(_collection).get();
    
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MaterialLog(
        id: doc.id,
        materialName: data['materialName'],
        quantity: data['quantity'],
        cost: data['cost'],
        date: DateTime.parse(data['date']),
        notes: data['notes'],
      );
    }).toList();
  }
  
  // Listen for real-time updates
  Stream<List<MaterialLog>> streamLogs() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return MaterialLog(
          id: doc.id,
          materialName: data['materialName'],
          quantity: data['quantity'],
          cost: data['cost'],
          date: DateTime.parse(data['date']),
          notes: data['notes'],
        );
      }).toList();
    });
  }
}
