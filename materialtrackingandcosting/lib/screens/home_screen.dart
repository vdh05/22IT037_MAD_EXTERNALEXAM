import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/material_log.dart';
import '../services/database_service.dart';
import '../services/cloud_sync_service.dart';
import '../services/export_service.dart';
import 'add_log_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final CloudSyncService _cloudSyncService = CloudSyncService();
  final ExportService _exportService = ExportService();
  List<MaterialLog> _logs = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Load from local database
    _logs = _databaseService.getAllLogs();
    
    setState(() {
      _isLoading = false;
    });
  }
  
  Future<void> _syncWithCloud() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Syncing with cloud...')),
    );
    
    await _cloudSyncService.syncToCloud(_logs);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sync completed')),
    );
  }
  
  Future<void> _exportAsPdf() async {
    try {
      final file = await _exportService.exportToPdf(_logs, 'Material Logs');
      await _exportService.shareFile(file);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: ${e.toString()}')),
      );
    }
  }
  
  Future<void> _exportAsCsv() async {
    try {
      final file = await _exportService.exportToCsv(_logs);
      await _exportService.shareFile(file);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Tracking'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'pdf') {
                _exportAsPdf();
              } else if (value == 'csv') {
                _exportAsCsv();
              } else if (value == 'sync') {
                _syncWithCloud();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'pdf',
                child: Text('Export as PDF'),
              ),
              const PopupMenuItem(
                value: 'csv',
                child: Text('Export as CSV'),
              ),
              const PopupMenuItem(
                value: 'sync',
                child: Text('Sync with Cloud'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _logs.isEmpty
              ? const Center(child: Text('No logs found. Add a new log.'))
              : ListView.builder(
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    final log = _logs[index];
                    return ListTile(
                      title: Text(log.materialName),
                      subtitle: Text('Quantity: ${log.quantity}, Cost: \$${log.cost}'),
                      trailing: Text('\$${(log.quantity * log.cost).toStringAsFixed(2)}'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to add log screen
          // When returning, reload data
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLogScreen()),
          );
          _loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
