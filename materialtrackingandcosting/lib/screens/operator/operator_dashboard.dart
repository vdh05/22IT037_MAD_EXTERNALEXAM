import 'package:flutter/material.dart';
import '../auth_screen.dart';
import 'material_scanning_screen.dart';
import '../test/test_barcodes_screen.dart';  // Add this import

class OperatorDashboard extends StatelessWidget {
  const OperatorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operator Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Operator Controls',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan Materials'),
              onTap: () {
                // Navigate to material scanning page
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const MaterialScanningScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('Log Consumption'),
              onTap: () {
                // Navigate to consumption logging page
                Navigator.pop(context);
                // Add navigation to consumption logging page here
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('My Assignments'),
              onTap: () {
                // Navigate to assignments page
                Navigator.pop(context);
                // Add navigation to assignments page here
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help'),
              onTap: () {
                // Navigate to help page
                Navigator.pop(context);
                // Add navigation to help page here
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text('Test Barcodes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestBarcodesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Operator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your assigned operations:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildOperationCard(
              context,
              'Material Scanning',
              'Scan materials to log them in the system',
              Icons.qr_code_scanner,
              Colors.blue,
            ),
            _buildOperationCard(
              context,
              'Log Material Consumption',
              'Record materials used in operations',
              Icons.edit_note,
              Colors.green,
            ),
            _buildOperationCard(
              context,
              'View Assignments',
              'Check your assigned operations and tasks',
              Icons.assignment,
              Colors.orange,
            ),
            const Spacer(),
            const Text(
              'Note: As an operator, you can only view and record data for your assigned operations.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationCard(
    BuildContext context, 
    String title, 
    String description, 
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          if (title == 'Material Scanning') {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const MaterialScanningScreen(),
              ),
            );
          }
          // Handle other card options
        },
      ),
    );
  }
}
